

// �Ƽ���ݼ� ctrl+/
//��ѡ��������˫б��ע�ͻ�ȡ��˫б��ע��
macro WangQiGuo_MultiLineComment()
{
    hwnd = GetCurrentWnd()
    selection = GetWndSel(hwnd)
    LnFirst = GetWndSelLnFirst(hwnd)      //ȡ�����к�
    LnLast = GetWndSelLnLast(hwnd)      //ȡĩ���к�
    hbuf = GetCurrentBuf()
 
    if(GetBufLine(hbuf, 0) == "//magic-number:tph85666031"){
        stop
    }
 
    Ln = Lnfirst
    buf = GetBufLine(hbuf, Ln)
    len = strlen(buf)
 
    while(Ln <= Lnlast) {
        buf = GetBufLine(hbuf, Ln)  //ȡLn��Ӧ����
        if(buf == ""){                    //��������
            Ln = Ln + 1
            continue
        }
 
        if(StrMid(buf, 0, 1) == "/") {       //��Ҫȡ��ע��,��ֹֻ�е��ַ�����
            if(StrMid(buf, 1, 2) == "/"){
                PutBufLine(hbuf, Ln, StrMid(buf, 2, Strlen(buf)))
            }
        }
 
        if(StrMid(buf,0,1) != "/"){          //��Ҫ���ע��
            PutBufLine(hbuf, Ln, Cat("//", buf))
        }
        Ln = Ln + 1
    }
 
    SetWndSel(hwnd, selection)
}

// �Ƽ���ݼ� ctrl+3
//��ѡ��Ĵ������ ��ȡ��#if 0  #endif ��Χ
macro WangQiGuo_AddMacroComment()
{
	hwnd=GetCurrentWnd()
	sel=GetWndSel(hwnd)
	lnFirst=GetWndSelLnFirst(hwnd)
	lnLast=GetWndSelLnLast(hwnd)
	hbuf=GetCurrentBuf()

	if (LnFirst == 0) 
	{
	        szIfStart = ""
	} 
	else 
	{
	        szIfStart = GetBufLine(hbuf, LnFirst-1) //��ѡ��ĵ�һ�е���һ�е�����
	}
	szIfEnd = GetBufLine(hbuf, lnLast+1) //��ѡ��Ĵ��������һ�е���һ������


	szCodeStart = GetBufLine(hbuf, LnFirst) //��ѡ��Ĵ����ĵ�һ������
	szCodeEnd = GetBufLine(hbuf, lnLast)//��ѡ��Ĵ��������һ������

	start_space_count = 0 //��һ�д����ǰ��Ŀհ׸���  ֻ����Tab����,���Կո�
	end_space_count = 0  //���һ�еĴ����ǰ��Ŀհ׸���
	insert_space_count = 0 //����Ҫ�����#if 0 �ַ���ǰ��Ӧ�ò�����ٸ�Tab

	index = 0

	while(index<strlen(szCodeStart))
	{
		if(AsciiFromChar(szCodeStart[index])== 9) //9��Tab�ַ���ASCII
		{
			start_space_count = start_space_count +1
		}
		index = index + 1 
	}

	index = 0
	while(index<strlen(szCodeEnd))
	{
		if(AsciiFromChar(szCodeEnd[index])== 9)
		{
			end_space_count=end_space_count+1
		}
		index = index + 1 
	}

	//�����ĵ�һ�к����һ��ǰ���Tab����,ȡ�Ƚ�С���Ǹ�ֵ
	if(start_space_count<end_space_count)
	{
		insert_space_count = start_space_count -1
	}
	else
	{
		insert_space_count = end_space_count -1
	}

	str_start_insert=""
	str_end_insert=""
	index=0

	while(index<insert_space_count)
	{
		str_start_insert=str_start_insert#"	"  //������ӵ�Tab�ַ�
		str_end_insert=str_end_insert#"	"  //������ӵ�Ҳ��Tab�ַ�
		index = index + 1 
	}
	str_start_insert=str_start_insert#"#if 0"    //��#if 0 ��ʼ���źͽ�������ǰ�����Tab�ַ�,�ȴ�����ǰ��Ŀհ���һ��
	str_end_insert=str_end_insert#"#endif"    

	if (_WangQiGuo_TrimString(szIfStart) == "#if 0" && _WangQiGuo_TrimString(szIfEnd) =="#endif") {
	        DelBufLine(hbuf, lnLast+1)
	        DelBufLine(hbuf, lnFirst-1)
	        sel.lnFirst = sel.lnFirst - 1
	        sel.lnLast = sel.lnLast - 1
	} 
	else 
	{
	        InsBufLine(hbuf, lnFirst, str_start_insert)
	        InsBufLine(hbuf, lnLast+2, str_end_insert)
	        sel.lnFirst = sel.lnFirst + 1
	        sel.lnLast = sel.lnLast + 1
	}
	SetWndSel( hwnd, sel )
}

// �Ƽ���ݼ� ctrl+8
//��ѡ�еĴ������Ӷ���ע��  
macro WangQiGuo_CommentSelStr()
{
	hwnd=GetCurrentWnd()
	sel=GetWndSel(hwnd)
	lnFirst=GetWndSelLnFirst(hwnd)
	lnLast=GetWndSelLnLast(hwnd)
	hbuf=GetCurrentBuf()

	if (LnFirst == 0) 
	{
	        szIfStart = ""
	} 
	else 
	{
	        szIfStart = GetBufLine(hbuf, LnFirst-1) //��ѡ��ĵ�һ�е���һ�е�����
	}
	szIfEnd = GetBufLine(hbuf, lnLast+1) //��ѡ��Ĵ��������һ�е���һ������


	szCodeStart = GetBufLine(hbuf, LnFirst) //��ѡ��Ĵ����ĵ�һ������
	szCodeEnd = GetBufLine(hbuf, lnLast)//��ѡ��Ĵ��������һ������

	start_space_count = 0 //��һ�д����ǰ��Ŀհ׸���  ֻ����Tab����,���Կո�
	end_space_count = 0  //���һ�еĴ����ǰ��Ŀհ׸���
	insert_space_count = 0

	index = 0

	while(index<strlen(szCodeStart))
	{
		if(AsciiFromChar(szCodeStart[index])== 9) //9��Tab�ַ���ASCII
		{
			start_space_count = start_space_count +1
		}
		index = index + 1 
	}

	index = 0
	while(index<strlen(szCodeEnd))
	{
		if(AsciiFromChar(szCodeEnd[index])== 9)
		{
			end_space_count=end_space_count+1
		}
		index = index + 1 
	}

	if(start_space_count<end_space_count)
	{
		insert_space_count = start_space_count -1
	}
	else
	{
		insert_space_count = end_space_count -1
	}

	str_start_insert=""
	str_end_insert=""
	index=0

	while(index<insert_space_count)
	{
		str_start_insert=str_start_insert#"	"  //������ӵ�Tab�ַ�
		str_end_insert=str_end_insert#"	"
		index = index + 1 
	}
	str_start_insert=str_start_insert#"/*"    //��ע�Ϳ�ʼ���źͽ�������ǰ�����Tab�ַ�,�ȴ�����ǰ��Ŀհ���һ��
	str_end_insert=str_end_insert#"*/"    

	if (_WangQiGuo_TrimString(szIfStart) == "/*" && _WangQiGuo_TrimString(szIfEnd) =="*/") {
	        DelBufLine(hbuf, lnLast+1)
	        DelBufLine(hbuf, lnFirst-1)
	        sel.lnFirst = sel.lnFirst - 1
	        sel.lnLast = sel.lnLast - 1
	} else {
	        InsBufLine(hbuf, lnFirst, str_start_insert)
	        InsBufLine(hbuf, lnLast+2, str_end_insert)
	        sel.lnFirst = sel.lnFirst + 1
	        sel.lnLast = sel.lnLast + 1
	}

	SetWndSel( hwnd, sel )
}



//ȥ����߿ո�,Tab��
macro _WangQiGuo_TrimLeft(szLine)
{
    nLen = strlen(szLine)
    if(nLen == 0)
    {
        return szLine
    }
    nIdx = 0
    while( nIdx < nLen )
    {
        if( ( szLine[nIdx] != " ") && (szLine[nIdx] != "\t") )
        {
            break
        }
        nIdx = nIdx + 1
    }
    return strmid(szLine,nIdx,nLen)
}


//ȥ���ַ����ұߵĿո�
macro _WangQiGuo_TrimRight(szLine)
{
    nLen = strlen(szLine)
    if(nLen == 0)
    {
        return szLine
    }
    nIdx = nLen
    while( nIdx > 0 )
    {
        nIdx = nIdx - 1
        if( ( szLine[nIdx] != " ") && (szLine[nIdx] != "\t") )
        {
            break
        }
    }
    return strmid(szLine,0,nIdx+1)
}

//ȥ���ַ������߿ո�
macro _WangQiGuo_TrimString(szLine)
{
    szLine = TrimLeft(szLine)
    szLIne = TrimRight(szLine)
    return szLine
}


