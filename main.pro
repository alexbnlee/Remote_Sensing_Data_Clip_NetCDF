PRO MAIN_EVENT, event

  IF WIDGET_INFO(event.ID, /uName) EQ 'cute_pet' THEN BEGIN
    WIDGET_TEST2
  ENDIF

  unames = WIDGET_INFO(event.id, /UNAME)

  CASE unames OF
    'LEAF11': BEGIN
      ;��ָ���ĳ���
      CD, FILE_DIRNAME(ROUTINE_FILEPATH()) + '\data_clip_nc'
      DATA_CLIP_NC
    END

    'LEAF12': BEGIN
      WIDGET_CONTROL, event.id, get_value = str
      PRINT, str
    END

    'LEAF21': BEGIN
      WIDGET_CONTROL, event.id, get_value = str
      PRINT, str
    END

    'LEAF22': BEGIN
      WIDGET_CONTROL, event.id, get_value = str
      PRINT, str
    END

    'LEAF31': BEGIN
      WIDGET_CONTROL, event.id, get_value = str
      PRINT, str
    END

    'LEAF32': BEGIN
      WIDGET_CONTROL, event.id, get_value = str
      PRINT, str
    END

    'LEAF41': BEGIN
      WIDGET_CONTROL, event.id, get_value = str
      PRINT, str
    END

    ELSE:
  ENDCASE

  CASE TAG_NAMES(event,/STRUCTURE_NAME) OF
    'WIDGET_KILL_REQUEST': BEGIN
      tmp = DIALOG_MESSAGE('ȷ�Ϲرգ�', $
        title='�ر�ϵͳ', /question)
      IF tmp EQ 'Yes' THEN BEGIN
        WIDGET_CONTROL, event.top, get_uValue = pState
        PTR_FREE, pState
        WIDGET_CONTROL, event.top, /destroy
        RETURN
      ENDIF
      RETURN
    END
    ELSE: RETURN
  ENDCASE

END



PRO MAIN

  ;������߼���base
  tlb = WIDGET_BASE(uvalue = 'tlb', xsize = 800, ysize = 800, $
    /TLB_KILL_REQUEST_EVENTS, title = 'IDL����')

  ;��ȡ��ʾ������
  DEVICE, get_screen_size = scr
  info = WIDGET_INFO(tlb, /geometry)
  scr_frm = [info.scr_xsize, info.scr_ysize]
  xyoffset = (scr-scr_frm)/2
  WIDGET_CONTROL, tlb, xoffset=xyoffset[0], yoffset=xyoffset[1]

  ;�ڲ�Ƕ��һ�������������С�ȵز��СһȦ
  tlb_0 = WIDGET_BASE(tlb, uvalue = 'tlb_0', /column)
  WIDGET_CONTROL, tlb_0, xsize = info.xsize - 40, ysize = info.ysize - 30, $
    xoffset = 20, yoffset = 15

  label_1 = WIDGET_LABEL(tlb_0, value = 'ѡ����Ӧ��ģ�飺', ysize = 35, /ALIGN_LEFT)

  ;��Ŀ¼
  wTree = WIDGET_TREE(tlb_0, ysize = 600)
  wtRoot = WIDGET_TREE(wTree, VALUE='IDL����ģ��', /FOLDER, /EXPANDED)
  ;�޸�Ĭ������
  ;widget_control, DEFAULT_FONT='Microsoft Yahei'

  ;��1���ļ���
  wtBranch1 = WIDGET_TREE(wtRoot, VALUE='DINEOF', $
    /FOLDER, /EXPANDED)
  wtLeaf11 = WIDGET_TREE(wtBranch1, value='���ݲü�', $
    uname='LEAF11')
  wtLeaf12 = WIDGET_TREE(wtBranch1, value='����ģ��', $
    uname='LEAF12')

  ;��2���ļ���
  wtBranch2 = WIDGET_TREE(wtRoot, VALUE='aodemu', $
    /FOLDER, /EXPANDED)
  wtLeaf21 = WIDGET_TREE(wtBranch2, VALUE='aodemu', $
    uname='LEAF21')
  wtLeaf22 = WIDGET_TREE(wtBranch2, VALUE='shishi', $
    uname='LEAF22')

  ;��3���ļ���
  wtBranch3 = WIDGET_TREE(wtRoot, VALUE='band_statistic', $
    /FOLDER, /EXPANDED)
  wtLeaf31 = WIDGET_TREE(wtBranch3, VALUE='band_statistic', $
    uname='LEAF31')
  wtLeaf32 = WIDGET_TREE(wtBranch3, VALUE='band_statistic_batch', $
    uname='LEAF32')

  ;��4���ļ���
  wtBranch4 = WIDGET_TREE(wtRoot, VALUE='BDH_HAB', $
    /FOLDER, /EXPANDED)
  wtLeaf41 = WIDGET_TREE(wtBranch4, VALUE='qhd_sst_from_global', $
    uname='LEAF41')

  WIDGET_CONTROL, tlb, /realize

  ;�����ṹ��
  state = {}

  ;����ָ��
  pstate = PTR_NEW(state, /no_copy)
  ;��ָ����Ϣ��ֵ
  WIDGET_CONTROL, tlb, set_uvalue = pstate

  XMANAGER, 'Main', tlb, /no_block

END