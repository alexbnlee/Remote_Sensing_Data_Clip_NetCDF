PRO Data_Clip_NC_EVENT, event

  ;HELP, event, /structure

  WIDGET_CONTROL, event.top, get_uValue = pState

  uName = WIDGET_INFO(event.id, /uname)

  CASE uName OF
    ;点击导入按钮，自动加载文本框路径，会自动添加路径到另外的文本框
    'button_31': BEGIN
      WIDGET_CONTROL, (*pState).text_311, get_value = pp
      path = DIALOG_PICKFILE(/DIRECTORY, TITLE='输入工作空间', PATH = pp)
      ;点击取消后，路径不发生变化
      IF path NE '' THEN BEGIN
        WIDGET_CONTROL, (*pState).text_311, set_value = path
        WIDGET_CONTROL, (*pState).text_511, set_value = path
      ENDIF
    END

    ;点击输出按钮，自动加载文本框路径
    'button_51': BEGIN
      WIDGET_CONTROL, (*pState).text_511, get_value = pp
      path = DIALOG_PICKFILE(/DIRECTORY, TITLE='输入工作空间', PATH = pp)
      ;点击取消后，路径不发生变化
      IF path NE '' THEN BEGIN
        WIDGET_CONTROL, (*pState).text_511, set_value = path
      ENDIF
    END

    ;点击下拉列表
    'droplist_71': BEGIN
      (*pState).sea_index = event.index
    END

    'button_n1': BEGIN
      ;运行程序，传递参数      输入路径      输出路径
      WIDGET_CONTROL, (*pState).text_311, get_value = path_in
      WIDGET_CONTROL, (*pState).text_511, get_value = path_out

      ;选择不用的区域，执行不同的代码
      CASE (*pState).sea_index OF
        0: BEGIN
          ;传回的数据是数组，直接运用会出错
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

  ;创建最高级别base
  tlb = WIDGET_BASE(uvalue = 'tlb', xsize = 800, ysize = 600, $
    ;标题
    title='数据裁切', $
    ;图标
    bitmap='D:\CODES\IDL\GUI_test\tool.ico', $
    ;不可以调整大小
    TLB_FRAME_ATTR = 1)
  ;获取显示器长宽
  DEVICE, get_screen_size = scr
  info = WIDGET_INFO(tlb, /geometry)
  scr_frm = [info.scr_xsize, info.scr_ysize]
  xyoffset = (scr-scr_frm)/2
  WIDGET_CONTROL, tlb, xoffset=xyoffset[0], yoffset=xyoffset[1]

  ;内部嵌入一层容器组件，大小比地层的小一圈
  tlb_0 = WIDGET_BASE(tlb, uvalue = 'tlb_0', /column)
  WIDGET_CONTROL, tlb_0, xsize = info.xsize - 40, ysize = info.ysize - 30, $
    xoffset = 20, yoffset = 15

  ;第1层 --- 描述
  tlb_1 = WIDGET_BASE(tlb_0, uname = 'tlb_1', ysize = 35)

  label_11 = WIDGET_LABEL(tlb_1, value = '实现功能：基于单点经纬度的现场数据与卫星数据的时空匹配，并写入文件', $
    uname = 'label_11')

  ;第2层 --- 输入
  tlb_2 = WIDGET_BASE(tlb_0, uname = 'tlb_2')
  label_21 = WIDGET_LABEL(tlb_2, uname='label_21', value=' 输入工作空间：')

  ;第3层 --- 文本框&按钮
  tlb_3 = WIDGET_BASE(tlb_0, uname = 'tlb_3', /row)

  tlb_31 = WIDGET_BASE(tlb_3, uname = 'tlb_31', /column)
  ;获取当前工作空间路径，并赋值给文本框
  CD, current=c
  text_311 = WIDGET_TEXT(tlb_31, uname='text_311', /editable, value = c)

  button_31 = WIDGET_BUTTON(tlb_3, uname='button_31', value='open.bmp', $
    /BITMAP)

  ;位置设置------------------------------------------------------------
  ;获取按钮的宽度
  info_tlb_3 = WIDGET_INFO(tlb_3, /geometry)
  info_tlb_31 = WIDGET_INFO(tlb_31, /geometry)
  info_button_31 = WIDGET_INFO(button_31, /geometry)
  info_text_311 = WIDGET_INFO(text_311, /geometry)

  WIDGET_CONTROL, tlb_31, $
    scr_xsize = info_tlb_3.scr_xsize - info_button_31.scr_xsize - 6 - 2

  ;第4层 --- 输出
  tlb_4 = WIDGET_BASE(tlb_0, uname = 'tlb_4')
  label_41 = WIDGET_LABEL(tlb_4, uname='label_41', value=' 输出路径：')

  ;第5层 --- 文本框&按钮
  tlb_5 = WIDGET_BASE(tlb_0, uname = 'tlb_5', /row)

  tlb_51 = WIDGET_BASE(tlb_5, uname = 'tlb_51', /column)
  text_511 = WIDGET_TEXT(tlb_51, uname='text_511', /editable, value = c)

  button_51 = WIDGET_BUTTON(tlb_5, uname='button_51', value='open.bmp', $
    /BITMAP)



  ;位置设置------------------------------------------------------------
  ;获取按钮的宽度
  info_tlb_5 = WIDGET_INFO(tlb_5, /geometry)
  info_tlb_51 = WIDGET_INFO(tlb_51, /geometry)
  info_button_51 = WIDGET_INFO(button_51, /geometry)
  info_text_511 = WIDGET_INFO(text_511, /geometry)

  WIDGET_CONTROL, tlb_51, $
    scr_xsize = info_tlb_5.scr_xsize - info_button_51.scr_xsize - 6 - 2


  ;第6层 --- 选择区域
  tlb_6 = WIDGET_BASE(tlb_0, uname = 'tlb_6')
  label_61 = WIDGET_LABEL(tlb_6, uname='label_61', value=' 选择截取区域及要素类型：')

  ;第7层 --- 下拉列表
  tlb_7 = WIDGET_BASE(tlb_0, uname = 'tlb_7', /column)

  tlb_71 = WIDGET_BASE(tlb_7, uname = 'tlb_71', /column)
  sea_areas = ['中国海域 -- SST', '浙江海域 -- SST', '南海海域 -- SST', '中国海域 -- CHL', $
    '中国海域 -- PAR', '浙江海域 -- RRS']
  sea_index = 0   ;选择的索引值，默认为0
  droplist_71 = WIDGET_DROPLIST(tlb_71, uname = 'droplist_71',$
    value=sea_areas)

  ;位置设置------------------------------------------------------------
  info_tlb_7 = WIDGET_INFO(tlb_7, /geometry)
  info_tlb_71 = WIDGET_INFO(tlb_71, /geometry)
  info_droplist_71 = WIDGET_INFO(droplist_71, /geometry)

  WIDGET_CONTROL, tlb_71, $
    scr_xsize = info_tlb_7.scr_xsize - 8
  info_tlb_71 = WIDGET_INFO(tlb_71, /geometry)

  WIDGET_CONTROL, droplist_71, $
    scr_xsize = info_tlb_71.scr_xsize - 8

  ;第space层 --- 空，用来调整距离
  tlb_s = WIDGET_BASE(tlb_0, uname = 'tlb_s', xsize = 20)

  ;第n层 --- 确定&取消按钮
  tlb_n = WIDGET_BASE(tlb_0, uname = 'tlb_n', /row)
  tlb_n1 = WIDGET_BASE(tlb_n, uname='tlb_n1', ysize = 20)
  button_n1 = WIDGET_BUTTON(tlb_n, uname='button_n1', value='确定', xsize = 150)
  tlb_n2 = WIDGET_BASE(tlb_n, uname='tlb_n2', xsize=1)
  button_n2 = WIDGET_BUTTON(tlb_n, uname='button_n2', value='取消', xsize = 150)

  ;位置设置------------------------------------------------------------
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