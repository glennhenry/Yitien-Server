package com.yiTian.view.modules.newRolePan
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.valuable.Enum_lib_attribute;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.data.vo.vo_otherRoleInfo;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.HtmlUtil;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ROther_rolePan extends Sprite
   {
      
      private static var _rightX:int = 360;
      
      public static const vecColor:Vector.<int> = new <int>[1,5,7,8,3];
      
      public static const TITLE:int = 0;
      
      public static const COLOR:int = 1;
      
      public static const YELI:int = 2;
      
      public static const DATA:int = 3;
      
      public static var arrNextCH:Array = [];
      
      private var slBtn:Button;
      
      private var otherTfVec1:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var _otherTfVec2:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var spBtnCon:Sprite;
      
      private var tfChengHao:MyTextField;
      
      private var outLineBm:Bitmap;
      
      private var zhanLiTf:MyTextField;
      
      public function ROther_rolePan()
      {
         var i:int = 0;
         var tf:MyTextField = null;
         var _tf:MyTextField = null;
         super();
         ComponentUtil.getScaleBitmap("Back_WenLi",[14,14,1,1],this,{
            "x":361 - _rightX,
            "y":5,
            "width":169,
            "height":475
         },Global.XJueSedm);
         this.tfChengHao = ComponentUtil.getTextField("称号:江湖称号",this,{
            "x":388 - _rightX,
            "y":43,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.spBtnCon = new Sprite();
         addChild(this.spBtnCon);
         ComponentUtil.setPropertie(this.spBtnCon,{
            "x":486 - _rightX,
            "y":43
         });
         ComponentUtil.getButton("","Button_OrangeUp",this.spBtnCon,{
            "x":0,
            "y":0,
            "textColor":16771436,
            "enabled":false
         },Global.XJueSedm);
         i = 0;
         while(i < 4)
         {
            tf = ComponentUtil.getTextField("",this,{
               "x":388 - _rightX,
               "y":77 + 20 * i,
               "color":11904647,
               "size":12,
               "leading":6
            });
            this.otherTfVec1.push(tf);
            i++;
         }
         i = 0;
         while(i < 10)
         {
            _tf = ComponentUtil.getTextField("",this,{
               "x":388 - _rightX,
               "y":176 + i * 20,
               "color":11904647,
               "size":12,
               "leading":6
            });
            this._otherTfVec2.push(_tf);
            i++;
         }
         ComponentUtil.getBitmap("Text_ShuXing",this,{
            "x":427 - _rightX,
            "y":15
         },Global.XJueSedm);
         ComponentUtil.getBitmap("Text_ZDLi",this,{
            "x":387 - _rightX,
            "y":406
         },Global.XJueSedm);
         this.zhanLiTf = ComponentUtil.getTextField("98765400",this,{
            "x":449 - _rightX,
            "y":404,
            "color":16776960,
            "size":16,
            "leading":0,
            "bold":true
         });
         ComponentUtil.getBitmap("BG_Light",this,{
            "x":368 - _rightX,
            "y":69
         },Global.XJueSedm);
         ComponentUtil.getBitmap("BG_Light",this,{
            "x":367 - _rightX,
            "y":166
         },Global.XJueSedm);
         ComponentUtil.getBitmap("BG_Light",this,{
            "x":367 - _rightX,
            "y":391
         },Global.XJueSedm);
         this.slBtn = ComponentUtil.getButton("实力对比","BT_SLDB",this,{
            "x":395 - _rightX,
            "y":438,
            "textColor":16771436
         },Global.XJueSedm);
         this.slBtn.addEventListener(MouseEvent.CLICK,this.compareHd);
         this.outLineBm = ComponentUtil.getBitmap("outLine",this,{
            "x":388 - _rightX + 65,
            "y":189
         },Global.XJueSedm);
         this.outLineBm.visible = false;
      }
      
      public function compareHd(e:MouseEvent) : void
      {
         visible = false;
         if(Boolean(parent) && parent is PaiHangRolePan)
         {
            (parent as PaiHangRolePan).changeView(2);
         }
         if(Boolean(parent) && parent is ComparePan)
         {
            (parent as ComparePan).changeView(2);
         }
      }
      
      public function update(vo_roleInfo:vo_otherRoleInfo) : void
      {
         var i:int = 0;
         var temStr:String = null;
         i = 0;
         while(i < 4)
         {
            if(i == 2)
            {
               temStr = OtherRoleMter[RoleMter.vec_str_attribute[i]];
               if(temStr == "")
               {
                  temStr = LangConfig.getWord("10015",1);
               }
               this.otherTfVec1[i].htmlText = Data_lib.attribute[RoleMter.vec_attribute[i]][Enum_lib_attribute.STR_NAME] + "：  " + HtmlUtil.font(temStr,ColorConstant.ROLE_ATTR_COLOR);
            }
            else if(i == 1)
            {
               this.otherTfVec1[i].htmlText = Data_lib.attribute[RoleMter.vec_attribute[i]][Enum_lib_attribute.STR_NAME] + "：  " + HtmlUtil.font(Model_bang.job_arr[Enum_job.getBaseJob(OtherRoleMter[RoleMter.vec_str_attribute[i]]) - 1],ColorConstant.ROLE_ATTR_COLOR);
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
            this._otherTfVec2[i].htmlText = Data_lib.attribute[RoleMter.vec_attribute[i + 4]][Enum_lib_attribute.STR_NAME] + "：  " + HtmlUtil.font(OtherRoleMter[RoleMter.vec_str_attribute[i + 4]],ColorConstant.ROLE_ATTR_COLOR);
            i++;
         }
         if(GameUnitManager.hero.id == vo_roleInfo.roleId)
         {
            this.slBtn.enabled = false;
         }
         else
         {
            this.slBtn.enabled = true;
         }
         this.zhanLiTf.htmlText = vo_roleInfo.strength.toString();
         this.updateChengHaoTip(vo_roleInfo.chengHao);
      }
      
      private function updateChengHaoTip(_chengHao:int) : void
      {
         var arrCurCH:Array = Data_lib.chengHao[_chengHao];
         var chengHao:int = _chengHao;
         if(chengHao == 0)
         {
            return;
         }
         var curColor:String = ColorConstant.getColorStr(vecColor[Data_lib.chengHao[_chengHao][COLOR] - 1]);
         arrNextCH = Data_lib.chengHao[_chengHao + 1];
         this.tfChengHao.htmlText = LangConfig.getWord("10094",1) + "<font color=\'" + "0x11904647" + "\'>" + arrCurCH[TITLE] + "</font>";
      }
   }
}

