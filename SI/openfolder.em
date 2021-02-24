


/**
 *  使用资源管理器打开当前文件所在文件夹，并个高亮选中当前文件 推荐快捷键 ctrl+T
 */
macro ToExplorerFolder()
{
	buf = GetCurrentBuf();
	curFilePath = GetBufName(buf);
	cmdLine = "explorer.exe /select,@curFilePath@";   // 其实就是通过explorer.exe 命令行直接打开 eg: explorer.exe /select,C:\xx.log 会自动选中xx.log
	RunCmdLine(cmdLine, Nil, 0);
}

//在sourceinsight的宏语言中，@str@ 可以连接两个字符串