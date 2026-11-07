package com.yiTian.view.modules.crossClanBattle
{
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.net.message.cg.CrossClanBattleCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   
   public class View_CrossChuanGongAlert extends Panel123
   {
      
      private var _tfMain:MyTextField;
      
      private var _cbNeverTip:CheckBox;
      
      private var sprIndex:int;
      
      private var urlArr:Array = ["Title_GJZY","Title_GSZY","Title_SHJC"];
      
      private var strArr:Array = ["攻击力","攻速","伤害加成"];
      
      private var strArrDes:Array = ["%","点","%"];
      
      private var titleBg:Bitmap = new Bitmap();
      
      public function View_CrossChuanGongAlert()
      {
         super();
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":358,
            "height":220
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":310,
            "height":170
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":34,
            "y":50,
            "width":290,
            "height":110
         },Global.Img_Cdm);
         move = new Rectangle(0,0,358,35);
         this._tfMain = ComponentUtil.getTextField("",this,{
            "x":65,
            "y":70,
            "color":13424242,
            "realWidth":230,
            "leading":4
         });
         this._tfMain.wordWrap = true;
         this._tfMain.align = TextFieldAutoSize.CENTER;
         this._cbNeverTip = ComponentUtil.getCheckBox("不再提示","CheckBox01",this,{
            "x":138,
            "y":130,
            "color":16777215
         },Global.Img_Cdm);
         ComponentUtil.getButton("确定","Button_Four",this,{
            "x":73,
            "y":170,
            "textColor":16184781,
            "callBack":this.okClickHd
         },Global.Img_Cdm);
         ComponentUtil.getButton("取消","Button_Four",this,{
            "x":213,
            "y":170,
            "textColor":16184781,
            "callBack":this.hide
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":324,
            "y":6,
            "textColor":16184781,
            "callBack":this.hide
         },Global.Img_Cdm);
      }
      
      public static function get instance() : View_CrossChuanGongAlert
      {
         return Singleton.getInstance(View_CrossChuanGongAlert);
      }
      
      public function show(index:int) : void
      {
         this.sprIndex = index;
         if(Boolean(this.titleBg) && Boolean(this.titleBg.parent) && this.titleBg.parent.contains(this.titleBg))
         {
            this.titleBg.parent.removeChild(this.titleBg);
         }
         Utils.loadTitle(Enum_CrossClanBattle.SRCURL,this.urlArr[this.sprIndex],this.titleBg,{
            "x":99,
            "y":5
         },this);
         this._tfMain.htmlText = "是否花费" + Model_CrossClanBattle.roleBuffArr[this.sprIndex][Enum_CrossClanBattle.BUFF_MONEY] + "元宝获得增益，增加人物 <font color=\'#33ff33\'>" + Model_CrossClanBattle.roleBuffArr[this.sprIndex][Enum_CrossClanBattle.BUFF_VALUE] + this.strArrDes[this.sprIndex] + "</font> 的" + this.strArr[this.sprIndex] + "<font color=\'#ff3333\'>（最高" + int(Model_CrossClanBattle.roleBuffArr[this.sprIndex][Enum_CrossClanBattle.BUFF_VALUE]) * 10 + this.strArrDes[this.sprIndex] + "）</font>";
         this._cbNeverTip.selected = Model_CrossClanBattle.canShowObject[this.sprIndex];
         if(Boolean(Model_CrossClanBattle.canShowObject[this.sprIndex]))
         {
            Model_CrossClanBattle.canShowObject[this.sprIndex] = this._cbNeverTip.selected;
            CrossClanBattleCGMessage.CG_BUY_ROLE_BUFF(int(Model_CrossClanBattle.roleBuffArr[this.sprIndex][Enum_CrossClanBattle.BUFF_ID]));
            this.visible = false;
         }
         else
         {
            this.visible = true;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,this.hide);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,this.hide);
         }
         super.visible = value;
      }
      
      private function okClickHd(p:* = null) : void
      {
         Model_CrossClanBattle.canShowObject[this.sprIndex] = this._cbNeverTip.selected;
         this.visible = false;
         CrossClanBattleCGMessage.CG_BUY_ROLE_BUFF(int(Model_CrossClanBattle.roleBuffArr[this.sprIndex][Enum_CrossClanBattle.BUFF_ID]));
      }
      
      private function hide(p:* = null) : void
      {
         this.visible = false;
         Model_CrossClanBattle.canShowObject[this.sprIndex] = false;
      }
   }
}

