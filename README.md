# SmartHashMap

[元ネタ](https://twitter.com/Magic_Gancelot/status/612964769880866817)

JSONをJavaのHashMapに変換するAntlrを使ったサンプル. 自由に使ってね.

## Installation

- [http://www.antlr.org/](http://www.antlr.org/)のQuick Startに従ってantlr4を入れます.
- `/usr/local/lib/antlr-4.5-complete.jar`をProcessingの`libraries`に以下のようになるように入れます.

```
(...)/Processing/libraries/antlr
└── library
    └── antlr.jar
```

```
$ cd antlr_sample
$ antlr4 Java.g4 && javac Java*.java
```

- Processingを起動して, antlr\_sampleを実行します.

## 何ができるの

```json:sample.java
HashMap map = {"a": 100, 1: [2, [3, [3.2, 3.4, [3.6, 3.8]]], 4], "b": [0, 1, [2, 3], 4]};
```

上記のようなコードを, 以下のように変換します.

```java
HashMap map = new HashMap <Object, Object> () {{ put ( "a" , 100 ) ;  put ( 1 , new Object[] { 2 , new Object[] { 3 , new Object[] { 3.2 , 3.4 , new Object[] { 3.6 , 3.8 } } } , 4 } ) ;  put ( "b" , new Object[] { 0 , 1 , new Object[] { 2 , 3 } , 4 } ) ; }} ;
```

## 追記
- あとはProcessingのModeにして自動で変換->コンパイルみたいなのを作ればよいと思うので, @gutugutu3030 先輩, @3846masa, @mimorisuzuko あたりに任せたいと思います.
