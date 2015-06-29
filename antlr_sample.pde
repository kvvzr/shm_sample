import java.util.*;
import java.lang.reflect.*;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;

Lexer lexer;
CommonTokenStream tokens;
Parser parser;

void setup() {
  try {
    String text = join(loadStrings("sample.pde"), "\n");
    lexer = new JavaLexer(new ANTLRInputStream(text));
    tokens = new CommonTokenStream(lexer);
    parser = new JavaParser(tokens);
    parser.setTokenStream(tokens);

    ClassLoader loader = Thread.currentThread().getContextClassLoader();
    Class<? extends Parser> parserClass = loader.loadClass("JavaParser").asSubclass(Parser.class);
    Method startRule = JavaParser.class.getMethod("classBodyDeclaration");
    ParserRuleContext tree = (ParserRuleContext)startRule.invoke(parser, (Object[])null);
    println(convertSmartHashMap(tree));
  } 
  catch (Exception e) {}
}

String convertSmartHashMap(ParseTree tree) {
  return convertSmartHashMap(tree, new ArrayList<String>());
}

private String convertSmartHashMap(ParseTree tree, List<String> exprs) {
  String result = "";
  if (tree.getChildCount() == 0) {
    Token token = (Token)tree.getPayload();
    String strToken = token.getText();

    while (exprs.size () > 0) {
      String expr = exprs.remove(exprs.size() - 1);
      if (expr.equals("jsonObject")) {
        if (strToken.equals("{")) {
          strToken = "new HashMap <Object, Object> () {{";
          break;
        }
        if (strToken.equals("}")) {
          strToken = "}}";
        }
        if (strToken.equals(",")) {
          strToken = "";
          break;
        }
        if (strToken.equals(":")) {
          strToken = ",";
          break;
        }
      }
      if (expr.equals("jsonArray")) {
        if (strToken.equals("[")) {
          strToken = "new Object[] {";
          break;
        } else if (strToken.equals("]")) {
          strToken = "}";
        } else {
          break;
        }
      }
      if (expr.equals("jsonPairKey")) {
        strToken = "put ( " + strToken;
        break;
      }
      if (expr.equals("jsonPairValue")) {
        strToken = strToken + " ) ;";
        break;
      }
    }

    return strToken + " ";
  }
  for (int i = 0; i < tree.getChildCount (); ++i) {
    List<String> childExprs = new ArrayList<String>(exprs);
    if (tree.toStringTree(parser).matches("^\\(jsonObject.*")) {
      childExprs.add("jsonObject");
    }
    if (tree.toStringTree(parser).matches("^\\(jsonArray.*")) {
      childExprs.add("jsonArray");
    }
    if (tree.toStringTree(parser).matches("^\\(jsonPairKey.*")) {
      childExprs.add("jsonPairKey");
    }
    if (tree.toStringTree(parser).matches("^\\(jsonPairValue.*")) {
      childExprs.add("jsonPairValue");
    }
    result += convertSmartHashMap(tree.getChild(i), childExprs);//t.toStringTree(parser).matches("¥A(jsonObject"), t.toStringTree(parser).matches("¥A(jsonArray"));
  }
  return result;
}

