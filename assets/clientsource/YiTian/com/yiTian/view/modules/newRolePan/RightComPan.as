package com.yiTian.view.modules.newRolePan
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.valuable.Enum_lib_attribute;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.data.vo.vo_otherRoleInfo;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class RightComPan extends Sprite
   {
      
      private static var _rightX:int = 360;
      
      private static var _gapWidth:int = 170;
      
      public static const vecColor:Vector.<int> = new <int>[1,5,7,8,3];
      
      public static const TITLE:int = 0;
      
      public static const COLOR:int = 1;
      
      public static const YELI:int = 2;
      
      public static const DATA:int = 3;
      
      public static var arrNextCH:Array = [];
      
      private var otherTfVec1:Vector.<MyTextField>;
      
      private var _otherTfVec1:Vector.<MyTextField>;
      
      private var otherTfVec2:Vector.<MyTextField>;
      
      private var _otherTfVec2:Vector.<MyTextField>;
      
      private var zhanLiTf:MyTextField;
      
      private var zhanLiTfMine:MyTextField;
      
      private var bmpVec:Vector.<Bitmap>;
      
      private var tfChengHaoMine:MyTextField;
      
      private var tfChengHaoYours:MyTextField;
      
      private var btnChengHaoMine:Button;
      
      private var btnChengHaoYours:Button;
      
      public function RightComPan()
      {
         var i:int = 0;
         var tf:MyTextField = null;
         var vecAtt:int = 0;
         var _tf:MyTextField = null;
         var vecAtt_:int = 0;
         var tf2:MyTextField = null;
         var _vecAtt:int = 0;
         var _tf2:MyTextField = null;
         var __vecAtt:int = 0;
         this.otherTfVec1 = new Vector.<MyTextField>();
         this._otherTfVec1 = new Vector.<MyTextField>();
         this.otherTfVec2 = new Vector.<MyTextField>();
         this._otherTfVec2 = new Vector.<MyTextField>();
         this.bmpVec = new Vector.<Bitmap>();
         super();
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":384,
            "height":480
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":382 - _rightX,
            "y":41,
            "width":338,
            "height":428
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_SLDuiBi",[30,20,1,1],this,{
            "x":383 - _rightX,
            "y":430,
            "width":336,
            "height":39
         },Global.XJueSedm);
         ComponentUtil.getButton("我要变强","BT_WYBQ",this,{
            "x":497 - _rightX,
            "y":438,
            "textColor":16771436,
            "callBack":function():void
            {
               WuXingMter.getPan(View_WYBQ,function(pan:View_WYBQ):void
               {
                  pan.visible = true;
               });
            }
         },Global.XJueSedm);
         ComponentUtil.getScaleBitmap("Back_ChuangWen",[11,11,1,1],this,{
            "x":551 - _rightX,
            "y":43,
            "width":167,
            "height":387
         },Global.XJueSedm);
         ComponentUtil.getScaleBitmap("Back_ChuangWen",[11,11,1,1],this,{
            "x":384 - _rightX,
            "y":43,
            "width":167,
            "height":387
         },Global.XJueSedm);
         this.tfChengHaoYours = ComponentUtil.getTextField("称号:江湖称号",this,{
            "x":410 - _rightX,
            "y":72,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.btnChengHaoMine = ComponentUtil.getButton("","Button_OrangeUp",this,{
            "x":512 - _rightX,
            "y":73,
            "textColor":16771436,
            "filters":Util.disabled
         },Global.XJueSedm);
         this.btnChengHaoMine.enabled = false;
         i = 0;
         while(i < 4)
         {
            tf = ComponentUtil.getTextField("",this,{
               "x":410 - _rightX,
               "y":100 + i * 20,
               "color":11904647,
               "size":12,
               "leading":6
            });
            tf.mouseEnabled = true;
            this.otherTfVec1.push(tf);
            vecAtt = RoleMter.vec_attribute[i];
            TipManager.bind(tf,Data_lib.attribute[vecAtt][Enum_lib_attribute.STR_DESCRIBE]);
            i++;
         }
         i = 0;
         while(i < 10)
         {
            _tf = ComponentUtil.getTextField("",this,{
               "x":410 - _rightX,
               "y":188 + i * 20,
               "color":11904647,
               "size":12,
               "leading":6
            });
            _tf.mouseEnabled = true;
            this._otherTfVec1.push(_tf);
            vecAtt_ = RoleMter.vec_attribute[i + 4];
            TipManager.bind(_tf,Data_lib.attribute[vecAtt_][Enum_lib_attribute.STR_DESCRIBE]);
            i++;
         }
         ComponentUtil.getBitmap("Text_ShuXing",this,{
            "x":449 - _rightX,
            "y":50
         },Global.XJueSedm);
         ComponentUtil.getBitmap("Text_ZDLi",this,{
            "x":409 - _rightX,
            "y":398
         },Global.XJueSedm);
         this.zhanLiTf = ComponentUtil.getTextField("98765400",this,{
            "x":471 - _rightX,
            "y":395,
            "color":16776960,
            "size":16,
            "leading":0,
            "bold":true
         });
         ComponentUtil.getBitmap("BG_Light",this,{
            "x":389 - _rightX,
            "y":96
         },Global.XJueSedm);
         ComponentUtil.getBitmap("BG_Light",this,{
            "x":389 - _rightX,
            "y":182
         },Global.XJueSedm);
         ComponentUtil.getBitmap("BG_Light",this,{
            "x":389 - _rightX,
            "y":390
         },Global.XJueSedm);
         i = 0;
         while(i < 4)
         {
            tf2 = ComponentUtil.getTextField("",this,{
               "x":410 - _rightX + _gapWidth,
               "y":100 + i * 20,
               "color":11904647,
               "size":12,
               "leading":6
            });
            tf2.mouseEnabled = true;
            this.otherTfVec2.push(tf2);
            _vecAtt = RoleMter.vec_attribute[i];
            TipManager.bind(tf2,Data_lib.attribute[_vecAtt][Enum_lib_attribute.STR_DESCRIBE]);
            i++;
         }
         i = 0;
         while(i < 10)
         {
            _tf2 = ComponentUtil.getTextField("",this,{
               "x":410 - _rightX + _gapWidth,
               "y":188 + i * 20,
               "color":11904647,
               "size":12,
               "leading":6
            });
            _tf2.mouseEnabled = true;
            this._otherTfVec2.push(_tf2);
            __vecAtt = RoleMter.vec_attribute[i + 4];
            TipManager.bind(_tf2,Data_lib.attribute[__vecAtt][Enum_lib_attribute.STR_DESCRIBE]);
            this.bmpVec.push(ComponentUtil.getBitmap("JianTou_Shang",this,{
               "x":695 - _rightX,
               "y":_tf2.y + 2
            },Global.XJueSedm));
            i++;
         }
         this.tfChengHaoMine = ComponentUtil.getTextField("称号:江湖称号",this,{
            "x":410 - _rightX + _gapWidth,
            "y":72,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.btnChengHaoYours = ComponentUtil.getButton("","Button_OrangeUp",this,{
            "x":501 - _rightX + _gapWidth,
            "y":73,
            "textColor":16771436,
            "filters":Util.disabled
         },Global.XJueSedm);
         this.btnChengHaoYours.enabled = false;
         ComponentUtil.getBitmap("Text_WDSX",this,{
            "x":429 - _rightX + _gapWidth,
            "y":50
         },Global.XJueSedm);
         ComponentUtil.getBitmap("Text_ZDLi",this,{
            "x":409 - _rightX + _gapWidth,
            "y":398
         },Global.XJueSedm);
         this.zhanLiTfMine = ComponentUtil.getTextField("98765400",this,{
            "x":471 - _rightX + _gapWidth,
            "y":395,
            "color":16776960,
            "size":16,
            "leading":0,
            "bold":true
         });
         ComponentUtil.getBitmap("BG_Light",this,{
            "x":389 - _rightX + _gapWidth,
            "y":96
         },Global.XJueSedm);
         ComponentUtil.getBitmap("BG_Light",this,{
            "x":389 - _rightX + _gapWidth,
            "y":182
         },Global.XJueSedm);
         ComponentUtil.getBitmap("BG_Light",this,{
            "x":389 - _rightX + _gapWidth,
            "y":390
         },Global.XJueSedm);
         ComponentUtil.getBitmap("Title_SLDuiBi",this,{
            "x":473 - _rightX,
            "y":5
         },Global.XJueSedm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":706 - _rightX,
            "y":6,
            "textColor":16771436,
            "callBack":function():void
            {
               visible = false;
               if(Boolean(parent) && parent is PaiHangRolePan)
               {
                  (parent as PaiHangRolePan).changeView(1);
               }
               if(Boolean(parent) && parent is ComparePan)
               {
                  (parent as ComparePan).changeView(1);
               }
            }
         },Global.Img_Cdm);
      }
      
      public function update(vo_roleInfo:vo_otherRoleInfo) : void
      {
         var i:int = 0;
         var temStr:String = null;
         i = 0;
         while(i < 4)
         {
            if(i == 1)
            {
               this.otherTfVec1[i].htmlText = Data_lib.attribute[RoleMter.vec_attribute[i]][Enum_lib_attribute.STR_NAME] + "：  " + HtmlUtil.font(Model_bang.job_arr[Enum_job.getBaseJob(OtherRoleMter[RoleMter.vec_str_attribute[i]]) - 1],ColorConstant.ROLE_ATTR_COLOR);
            }
            else if(i == 2)
            {
               temStr = OtherRoleMter[RoleMter.vec_str_attribute[i]];
               if(temStr == "")
               {
                  temStr = LangConfig.getWord("10015",1);
               }
               this.otherTfVec1[i].htmlText = Data_lib.attribute[RoleMter.vec_attribute[i]][Enum_lib_attribute.STR_NAME] + "：  " + HtmlUtil.font(temStr,ColorConstant.ROLE_ATTR_COLOR);
            }
            else
            {
               this.otherTfVec1[i].htmlText = Data_lib.attribute[RoleMter.vec_attribute[i]][Enum_lib_attribute.STR_NAME] + "：  " + HtmlUtil.font(OtherRoleMter[RoleMter.vec_str_attribute[i]],ColorConstant.ROLE_ATTR_COLOR);
            }
            i++;
         }
         i = 0;
         while(i < 10)
         {
            this._otherTfVec1[i].htmlText = Data_lib.attribute[RoleMter.vec_attribute[i + 4]][Enum_lib_attribute.STR_NAME] + "：  " + HtmlUtil.font(OtherRoleMter[RoleMter.vec_str_attribute[i + 4]],ColorConstant.ROLE_ATTR_COLOR);
            i++;
         }
         this.zhanLiTf.htmlText = vo_roleInfo.strength.toString();
         this.updateChengHaoTip(vo_roleInfo.chengHao,this.tfChengHaoYours);
         this.showMine();
      }
      
      private function showMine() : void
      {
         var i:int = 0;
         var temStr:String = null;
         var mine:int = 0;
         var other:int = 0;
         var bm:Bitmap = null;
         i = 0;
         while(i < 4)
         {
            if(i == 1)
            {
               this.otherTfVec2[i].htmlText = Data_lib.attribute[RoleMter.vec_attribute[i]][Enum_lib_attribute.STR_NAME] + "：  " + HtmlUtil.font(Model_bang.job_arr[Enum_job.getBaseJob(GameUnitManager.hero[RoleMter.vec_str_attribute[i]]) - 1],ColorConstant.ROLE_ATTR_COLOR);
            }
            else if(i == 2)
            {
               temStr = GameUnitManager.hero[RoleMter.vec_str_attribute[i]];
               if(temStr == "")
               {
                  temStr = LangConfig.getWord("10015",1);
               }
               this.otherTfVec2[i].htmlText = Data_lib.attribute[RoleMter.vec_attribute[i]][Enum_lib_attribute.STR_NAME] + "：  " + HtmlUtil.font(temStr,ColorConstant.ROLE_ATTR_COLOR);
            }
            else
            {
               this.otherTfVec2[i].htmlText = Data_lib.attribute[RoleMter.vec_attribute[i]][Enum_lib_attribute.STR_NAME] + "：  " + HtmlUtil.font(GameUnitManager.hero[RoleMter.vec_str_attribute[i]],ColorConstant.ROLE_ATTR_COLOR);
            }
            i++;
         }
         i = 0;
         while(i < 10)
         {
            this._otherTfVec2[i].htmlText = Data_lib.attribute[RoleMter.vec_attribute[i + 4]][Enum_lib_attribute.STR_NAME] + "：  " + HtmlUtil.font(GameUnitManager.hero[RoleMter.vec_str_attribute[i + 4]],ColorConstant.ROLE_ATTR_COLOR);
            i++;
         }
         i = 0;
         while(i < 10)
         {
            mine = int(GameUnitManager.hero[RoleMter.vec_str_attribute[i + 4]]);
            other = int(OtherRoleMter[RoleMter.vec_str_attribute[i + 4]]);
            bm = this.bmpVec[i];
            if(mine > other)
            {
               bm.bitmapData = ComponentUtil.getBitmapData("JianTou_Shang",Global.XJueSedm);
            }
            else if(mine < other)
            {
               bm.bitmapData = ComponentUtil.getBitmapData("JianTou_Xia",Global.XJueSedm);
            }
            else
            {
               bm.bitmapData = null;
            }
            i++;
         }
         this.updateChengHaoTip(GameUnitManager.hero.chengHao,this.tfChengHaoMine);
         this.zhanLiTfMine.htmlText = GameUnitManager.hero.strength.toString();
      }
      
      private function updateChengHaoTip(_chengHao:int, tf:MyTextField) : void
      {
         var arrCurCH:Array = Data_lib.chengHao[_chengHao];
         var chengHao:int = _chengHao;
         if(chengHao == 0)
         {
            return;
         }
         var curColor:String = ColorConstant.getColorStr(vecColor[Data_lib.chengHao[_chengHao][COLOR] - 1]);
         arrNextCH = Data_lib.chengHao[_chengHao + 1];
         tf.htmlText = LangConfig.getWord("10094",1) + "<font color=\'" + "0x11904647" + "\'>" + arrCurCH[TITLE] + "</font>";
      }
   }
}

