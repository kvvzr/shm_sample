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
