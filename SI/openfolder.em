


/**
 *  ʹ����Դ�������򿪵�ǰ�ļ������ļ��У���������ѡ�е�ǰ�ļ� �Ƽ���ݼ� ctrl+T
 */
macro ToExplorerFolder()
{
	buf = GetCurrentBuf();
	curFilePath = GetBufName(buf);
	cmdLine = "explorer.exe /select,@curFilePath@";   // ��ʵ����ͨ��explorer.exe ������ֱ�Ӵ� eg: explorer.exe /select,C:\xx.log ���Զ�ѡ��xx.log
	RunCmdLine(cmdLine, Nil, 0);
}

//��sourceinsight�ĺ������У�@str@ �������������ַ���