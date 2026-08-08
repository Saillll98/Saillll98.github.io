# Sail's Blog 维护指南

本站的本地目录是 `E:\mywebsite`，公开地址是 [https://saillll98.github.io/](https://saillll98.github.io/)。

以后新增或修改文章，主要会用到下面这几个位置：

| 要做的事 | 需要修改的位置 |
| --- | --- |
| 新增课程或技术文章 | `docs/course/`下的 Markdown 文件 |
| 把文章显示在课程列表 | `docs/course/index.md` |
| 修改主页 | `docs/index.md` |
| 修改友链 | `docs/friends/index.md` |
| 修改自我介绍 | `docs/about/index.md` |
| 修改网站顶部导航 | `mkdocs.yml` 里的 `nav` |
| 修改颜色、字号或页面样式 | `docs/stylesheets/extra.css` |

## 一、新增一篇文章

### 方法 A：复制现有示例（推荐）

1. 用文件资源管理器打开 `E:\mywebsite\docs\course`。
2. 复制 `example.md`。
3. 将副本改成新文件名，例如 `python-basics.md`。
4. 用 VS Code、记事本或其他文本编辑器打开它。
5. 替换标题和正文，然后保存。

文件名建议使用小写英文、数字和短横线，不要使用空格。这样产生的网址更简洁，例如：

```text
python-basics.md
git-for-beginners.md
lesson-01.md
```

### 文章的基本格式

````markdown
# 文章标题

用一小段话介绍这篇文章要解决什么问题。

## 准备工作

- 需要准备的工具
- 需要掌握的基础知识

## 操作步骤

### 1. 第一步

详细说明。

```python
print("Hello, Sail!")
```

## 总结

- 核心知识点一
- 核心知识点二
````

也可以直接参考仓库中的 [示例文章](docs/course/example.md)。

### 把新文章加到列表

仅创建 Markdown 文件后，文章已经可以构建，但读者不容易找到它。请继续编辑 `docs/course/index.md`，在“文章列表”下增加一行：

```markdown
- [Python 入门](python-basics.md)
```

括号里的文件名必须与新文章完全一致。

### 什么时候需要修改 `mkdocs.yml`

如果新文章只需要出现在“课程”页的文章列表中，不用修改 `mkdocs.yml`。

只有想把新页面放到网站顶部导航时，才需要在 `nav` 中增加它。其中的文件路径都相对于 `docs` 目录。

## 二、发布前本地预览

1. 双击 `E:\mywebsite\start-mkdocs.bat`。
2. 等待浏览器打开 `http://127.0.0.1:8000`。
3. 检查文章标题、链接、代码块和排版。
4. 检查完成后，在黑色窗口按 `Ctrl+C` 停止预览。

## 三、手动推送到 GitHub

打开 PowerShell，依次运行：

```powershell
cd E:\mywebsite
py -m mkdocs build --strict
git status
git add --all
git commit -m "Add Python basics article"
git push origin main
```

这几行命令的意思是：

1. 进入网站目录。
2. 检查网站能否正常生成。
3. 查看修改了哪些文件。
4. 选中这些修改。
5. 生成一条本地版本记录。
6. 把版本记录推送到 GitHub 的 `main` 分支。

提交说明建议用一句简短的英文或中文说明做了什么，例如：

```text
Add Python basics article
Update friends page
修改关于页介绍
```

> 注意：上传前应先用 `git status` 检查文件列表。不要上传密码、令牌、身份证件或其他私密资料。

## 四、使用自动脚本推送（推荐）

可以。本项目已提供 `publish.bat`。

### 使用步骤

1. 写完并保存文章。
2. 双击 `E:\mywebsite\publish.bat`。
3. 脚本会检查远端版本和 MkDocs 构建。
4. 它会列出本次改动的文件。
5. 输入提交说明，例如 `Add lesson 2`。
6. 确认文件列表中没有私密资料后，输入 `Y` 并按回车。
7. 看到“推送完成”后即可关闭窗口。

脚本不会绕过确认直接上传。如果网站构建失败、远端有新版本或 GitHub 无法连接，它会停下并显示提示。

## 五、推送后会发生什么

1. 新版本被推送到 GitHub 的 `main` 分支。
2. `.github/workflows/ci.yml` 会自动运行。
3. GitHub 会安装 Material for MkDocs 并检查网站。
4. 构建结果会被发布到 `gh-pages` 分支。
5. 通常等待 1～3 分钟后，公开网站就会更新。

可以在 [GitHub Actions](https://github.com/Saillll98/Saillll98.github.io/actions) 查看进度。绿色对勾表示发布成功，红色叉表示需要检查错误。

## 六、常见问题

### 显示 `nothing to commit`

表示 Git 没有发现新修改。请确认文章已保存，并且修改的是 `E:\mywebsite` 里的文件。

### 显示远端有新版本

先不要强制推送。打开 PowerShell 后运行：

```powershell
cd E:\mywebsite
git pull --ff-only origin main
```

成功后再重新双击 `publish.bat`。如果拉取失败，请把完整错误文字发给 Codex。

### GitHub 网页没有立即更新

先打开 GitHub Actions 检查构建是否出现绿色对勾，再等待几分钟并按 `Ctrl+F5` 强制刷新公开网站。

### 可以直接修改 `site/` 吗？

不可以。`site/` 是 MkDocs 自动生成的目录，下次构建时会被重新生成。请始终修改 `docs/` 和 `mkdocs.yml`。

### 可以直接修改 `gh-pages` 分支吗？

不要手动修改。`gh-pages` 是自动发布结果，每次推送 `main` 后都可能被重新生成。
