# 如何写一篇技术博客

> 这是一篇示例文章。以后可以复制这个文件，再替换标题和内容。

## 文章摘要

用两三句话说明这篇文章要解决什么问题、适合哪些读者，以及读完后能获得什么。

## 准备工作

开始前，建议准备好：

- Python 3.10 或更高版本
- 一个文本编辑器
- 基本的命令行操作经验

## 实现步骤

### 1. 安装依赖

先运行下面的命令：

```bash
python -m pip install example-package
```

### 2. 编写代码

代码块应该尽量完整，并在前后解释它的作用：

```python
def greet(name: str) -> str:
    """返回一句问候语。"""
    return f"Hello, {name}!"


print(greet("Sail"))
```

### 3. 检查结果

运行代码后，你应该看到：

```text
Hello, Sail!
```

!!! tip "写作建议"
    如果某一步容易出错，可以用这种提示框说明常见问题和解决方法。

## 总结

文章结尾用简短的列表回顾核心内容：

- 说明了要解决的问题
- 给出了可复现的操作步骤
- 提供了代码、结果和排错提示

## 参考资料

- [MkDocs 官方文档](https://www.mkdocs.org/)
- [Material for MkDocs 文档](https://squidfunk.github.io/mkdocs-material/)
