PRO Data_Clip_NC_EVENT, event

  ;HELP, event, /structure

  WIDGET_CONTROL, event.top, get_uValue = pState

  uName = WIDGET_INFO(event.id, /uname)

  CASE uName OF
    ;������밴ť���Զ������ı���·�������Զ����·����������ı���
    'button_31': BEGIN
      WIDGET_CONTROL, (*pState).text_311, get_value = pp
      path = DIALOG_PICKFILE(/DIRECTORY, TITLE='���빤���ռ�', PATH = pp)
      ;���ȡ����·���������仯
      IF path NE '' THEN BEGIN
        WIDGET_CONTROL, (*pState).text_311, set_value = path
        WIDGET_CONTROL, (*pState).text_511, set_value = path
      ENDIF
    END

    ;��������ť���Զ������ı���·��
    'button_51': BEGIN
      WIDGET_CONTROL, (*pState).text_511, get_value = pp
      path = DIALOG_PICKFILE(/DIRECTORY, TITLE='���빤���ռ�', PATH = pp)
      ;���ȡ����·���������仯
      IF path NE '' THEN BEGIN
        WIDGET_CONTROL, (*pState).text_511, set_value = path
      ENDIF
    END

    ;��������б�
    'droplist_71': BEGIN
      (*pState).sea_index = event.index
    END

    'button_n1': BEGIN
      ;���г��򣬴��ݲ���      ����·��      ���·��
      WIDGET_CONTROL, (*pState).text_311, get_value = path_in
      WIDGET_CONTROL, (*pState).text_511, get_value = path_out

      ;ѡ���õ�����ִ�в�ͬ�Ĵ���
      CASE (*pState).sea_index OF
        0: BEGIN
          ;���ص����������飬ֱ�����û����
          CHINA_SST_FROM_GLOBAL_NC, path_in[0], path_out[0]
        END
        1: BEGIN
          ZHEJIANG_SST_FROM_GLOBAL_NC, path_in[0], path_out[0]
        END
        2: BEGIN
          Nanhai_SST_from_Global_nc, path_in[0], path_out[0]
        END
        3: BEGIN
          China_CHL_from_Global_nc, path_in[0], path_out[0]
        END
        4: BEGIN
          China_PAR_from_Global_nc, path_in[0], path_out[0]
        END
        5: BEGIN
          China_RRS_from_Global_nc, path_in[0], path_out[0]
        END
        ELSE: BEGIN
        END
      ENDCASE

    END

    'button_n2': BEGIN
      PTR_FREE, pState
      WIDGET_CONTROL, event.top, /destroy
      RETURN
    END

    ELSE: BEGIN
    END

  ENDCASE

END

PRO Data_Clip_NC

  ;������߼���base
  tlb = WIDGET_BASE(uvalue = 'tlb', xsize = 800, ysize = 600, $
    ;����
    title='���ݲ���', $
    ;ͼ��
    bitmap='D:\CODES\IDL\GUI_test\tool.ico', $
    ;�����Ե�����С
    TLB_FRAME_ATTR = 1)
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

  ;��1�� --- ����
  tlb_1 = WIDGET_BASE(tlb_0, uname = 'tlb_1', ysize = 35)

  label_11 = WIDGET_LABEL(tlb_1, value = 'ʵ�ֹ��ܣ����ڵ��㾭γ�ȵ��ֳ��������������ݵ�ʱ��ƥ�䣬��д���ļ�', $
    uname = 'label_11')

  ;��2�� --- ����
  tlb_2 = WIDGET_BASE(tlb_0, uname = 'tlb_2')
  label_21 = WIDGET_LABEL(tlb_2, uname='label_21', value=' ���빤���ռ䣺')

  ;��3�� --- �ı���&��ť
  tlb_3 = WIDGET_BASE(tlb_0, uname = 'tlb_3', /row)

  tlb_31 = WIDGET_BASE(tlb_3, uname = 'tlb_31', /column)
  ;��ȡ��ǰ�����ռ�·��������ֵ���ı���
  CD, current=c
  text_311 = WIDGET_TEXT(tlb_31, uname='text_311', /editable, value = c)

  button_31 = WIDGET_BUTTON(tlb_3, uname='button_31', value='open.bmp', $
    /BITMAP)

  ;λ������------------------------------------------------------------
  ;��ȡ��ť�Ŀ��
  info_tlb_3 = WIDGET_INFO(tlb_3, /geometry)
  info_tlb_31 = WIDGET_INFO(tlb_31, /geometry)
  info_button_31 = WIDGET_INFO(button_31, /geometry)
  info_text_311 = WIDGET_INFO(text_311, /geometry)

  WIDGET_CONTROL, tlb_31, $
    scr_xsize = info_tlb_3.scr_xsize - info_button_31.scr_xsize - 6 - 2

  ;��4�� --- ���
  tlb_4 = WIDGET_BASE(tlb_0, uname = 'tlb_4')
  label_41 = WIDGET_LABEL(tlb_4, uname='label_41', value=' ���·����')

  ;��5�� --- �ı���&��ť
  tlb_5 = WIDGET_BASE(tlb_0, uname = 'tlb_5', /row)

  tlb_51 = WIDGET_BASE(tlb_5, uname = 'tlb_51', /column)
  text_511 = WIDGET_TEXT(tlb_51, uname='text_511', /editable, value = c)

  button_51 = WIDGET_BUTTON(tlb_5, uname='button_51', value='open.bmp', $
    /BITMAP)



  ;λ������------------------------------------------------------------
  ;��ȡ��ť�Ŀ��
  info_tlb_5 = WIDGET_INFO(tlb_5, /geometry)
  info_tlb_51 = WIDGET_INFO(tlb_51, /geometry)
  info_button_51 = WIDGET_INFO(button_51, /geometry)
  info_text_511 = WIDGET_INFO(text_511, /geometry)

  WIDGET_CONTROL, tlb_51, $
    scr_xsize = info_tlb_5.scr_xsize - info_button_51.scr_xsize - 6 - 2


  ;��6�� --- ѡ������
  tlb_6 = WIDGET_BASE(tlb_0, uname = 'tlb_6')
  label_61 = WIDGET_LABEL(tlb_6, uname='label_61', value=' ѡ���ȡ����Ҫ�����ͣ�')

  ;��7�� --- �����б�
  tlb_7 = WIDGET_BASE(tlb_0, uname = 'tlb_7', /column)

  tlb_71 = WIDGET_BASE(tlb_7, uname = 'tlb_71', /column)
  sea_areas = ['�й����� -- SST', '�㽭���� -- SST', '�Ϻ����� -- SST', '�й����� -- CHL', $
    '�й����� -- PAR', '�㽭���� -- RRS']
  sea_index = 0   ;ѡ�������ֵ��Ĭ��Ϊ0
  droplist_71 = WIDGET_DROPLIST(tlb_71, uname = 'droplist_71',$
    value=sea_areas)

  ;λ������------------------------------------------------------------
  info_tlb_7 = WIDGET_INFO(tlb_7, /geometry)
  info_tlb_71 = WIDGET_INFO(tlb_71, /geometry)
  info_droplist_71 = WIDGET_INFO(droplist_71, /geometry)

  WIDGET_CONTROL, tlb_71, $
    scr_xsize = info_tlb_7.scr_xsize - 8
  info_tlb_71 = WIDGET_INFO(tlb_71, /geometry)

  WIDGET_CONTROL, droplist_71, $
    scr_xsize = info_tlb_71.scr_xsize - 8

  ;��space�� --- �գ�������������
  tlb_s = WIDGET_BASE(tlb_0, uname = 'tlb_s', xsize = 20)

  ;��n�� --- ȷ��&ȡ����ť
  tlb_n = WIDGET_BASE(tlb_0, uname = 'tlb_n', /row)
  tlb_n1 = WIDGET_BASE(tlb_n, uname='tlb_n1', ysize = 20)
  button_n1 = WIDGET_BUTTON(tlb_n, uname='button_n1', value='ȷ��', xsize = 150)
  tlb_n2 = WIDGET_BASE(tlb_n, uname='tlb_n2', xsize=1)
  button_n2 = WIDGET_BUTTON(tlb_n, uname='button_n2', value='ȡ��', xsize = 150)

  ;λ������------------------------------------------------------------
  info_tlb_0 = WIDGET_INFO(tlb_0, /geometry)
  info_tlb_s = WIDGET_INFO(tlb_s, /geometry)
  info_tlb_n = WIDGET_INFO(tlb_n, /geometry)
  info_button_n2 = WIDGET_INFO(button_n2, /geometry)

  WIDGET_CONTROL, tlb_s, $
    ysize = info_tlb_0.scr_ysize - info_tlb_s.yoffset - $
    info_tlb_n.scr_ysize - 6 - 2

  WIDGET_CONTROL, tlb_n1, $
    xsize = info_tlb_0.scr_xsize - 150 * 2 - 23

  state = {tlb_0:tlb_0, $
    tlb_3:tlb_3, $
    tlb_31:tlb_31, $
    button_31:button_31, $
    text_311:text_311, $
    tlb_5:tlb_5, $
    tlb_51:tlb_51, $
    button_51:button_51, $
    text_511:text_511, $
    tlb_7:tlb_7, $
    tlb_71:tlb_71, $
    droplist_71:droplist_71, $
    sea_areas:sea_areas, $
    sea_index:sea_index, $
    tlb_s:tlb_s, $
    tlb_n:tlb_n, $
    tlb_n1:tlb_n1}

  pState = PTR_NEW(state, /no_copy)
  WIDGET_CONTROL, tlb, set_uvalue = pState

  WIDGET_CONTROL, DEFAULT_FONT='Microsoft Yahei'

  WIDGET_CONTROL, tlb, /realize

  XMANAGER, 'Data_Clip_NC', tlb, /no_block

END