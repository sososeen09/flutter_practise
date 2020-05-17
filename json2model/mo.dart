import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

const TAG = "\$";
const SRC = "./json/"; //JSON 目录
const DIST = "../lib/models/"; //输出model目录

void walkDirectory(String path, String relativePath) {
  var src = Directory(path);
  src.list(recursive: false, followLinks: false)
      //读取每一个文件对象
      .listen((FileSystemEntity entity) {
    //查看文件对象的类型和路径
    FileSystemEntity.type(entity.path).then((FileSystemEntityType type) {
      String label;
      //判断文件类型
      switch (type) {
        case FileSystemEntityType.directory:
          walkDirectory(
              entity.path, "$relativePath/${entity.path.split("/").last}");
          label = '目录';
          break;
        case FileSystemEntityType.file:
          assembleCodeFile(entity.path, relativePath);
          label = '文件';
          break;
        case FileSystemEntityType.link:
          label = '链接';
          break;
        default:
          label = '未知';
      }
      //输出文件类型与路径
      print('$label：${entity.path}');
    });
  });
}

File file;
var template = new File("./template.dart.t").readAsStringSync();
void assembleCodeFile(String jsonFilePath, String directoryPath) {
  if (FileSystemEntity.isFileSync(jsonFilePath)) {
    file = new File(jsonFilePath);
    var paths = path.basename(jsonFilePath).split(".");
    String name = paths.first;
    if (paths.last.toLowerCase() != "json" || name.startsWith("_")) return;
    if (name.startsWith("_")) return;
    //下面生成模板
    print("===============");
    print("【jsonFilePath】: $jsonFilePath");
    print("【directoryPath】: $directoryPath");
    print("【name】: $name");
    var map = json.decode(file.readAsStringSync());
    //为了避免重复导入相同的包，我们用Set来保存生成的import语句。
    var set = new Set<String>();
    StringBuffer attrs = new StringBuffer();
    (map as Map<String, dynamic>).forEach((key, v) {
      if (key.startsWith("_")) return;
      attrs.write(getType(v, set, name));
      attrs.write(" ");
      attrs.write(key);
      attrs.writeln(";");
      attrs.write("  ");
    });
    String className = name[0].toUpperCase() + name.substring(1);
    var dist = format(template, [
      name,
      className,
      className,
      attrs.toString(),
      className,
      className,
      className
    ]);
    var _import = set.join(";\r\n");
    _import += _import.isEmpty ? "" : ";";
    dist = dist.replaceFirst("%t", _import);
    //将生成的模板输出
    var saveDirectoryPath = Directory("$DIST$directoryPath");
    saveDirectoryPath.create(recursive: true).then((Directory dir) {
      File("${saveDirectoryPath.path}/$name.dart").writeAsStringSync(dist);
    });
  }
}

void walk() {
  //遍历JSON目录生成模板
  walkDirectory(SRC, "");
}

String changeFirstChar(String str, [bool upper = true]) {
  return (upper ? str[0].toUpperCase() : str[0].toLowerCase()) +
      str.substring(1);
}

//将JSON类型转为对应的dart类型
String getType(v, Set<String> set, String current) {
  current = current.toLowerCase();
  if (v is bool) {
    return "bool";
  } else if (v is num) {
    return "num";
  } else if (v is Map) {
    return "Map<String,dynamic>";
  } else if (v is List) {
    return "List";
  } else if (v is String) {
    //处理特殊标志
    if (v.startsWith("$TAG[]")) {
      var className = changeFirstChar(v.substring(3), false);
      if (className.toLowerCase() != current) {
        set.add('import "$className.dart"');
      }
      return "List<${changeFirstChar(className)}>";
    } else if (v.startsWith(TAG)) {
      var fileName = changeFirstChar(v.substring(1), false);
      if (fileName.toLowerCase() != current) {
        set.add('import "$fileName.dart"');
      }
      return changeFirstChar(fileName);
    }
    return "String";
  } else {
    return "String";
  }
}

//替换模板占位符
String format(String fmt, List<Object> params) {
  int matchIndex = 0;
  String replace(Match m) {
    if (matchIndex < params.length) {
      switch (m[0]) {
        case "%s":
          return params[matchIndex++].toString();
      }
    } else {
      throw new Exception("Missing parameter for string format");
    }
    throw new Exception("Invalid format string: " + m[0].toString());
  }

  return fmt.replaceAllMapped("%s", replace);
}

void main() {
  walk();
}
