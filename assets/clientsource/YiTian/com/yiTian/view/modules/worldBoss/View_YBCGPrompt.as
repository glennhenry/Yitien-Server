package com.yiTian.view.modules.worldBoss
{
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.WorldBossCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   
   public class View_YBCGPrompt extends Panel123
   {
      
      private static var _instance:View_YBCGPrompt;
      
      private var _tfMain:MyTextField;
      
      private var _cbNeverTip:CheckBox;
      
      public function View_YBCGPrompt()
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
         this._tfMain.htmlText = "是否花费 " + Config_WorldBoss.CG_MONEY_COST.toString() + " 元宝 邀请独孤大侠传功，增加人物 <font color=\'#33ff33\'>10%</font> 的攻击力<font color=\'#ff3333\'>（最高100%）</font>";
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
         Utils.loadTitle("lang/ch/WuHun_Imgs.swf","Title_YBCG",new Bitmap(),{
            "x":99,
            "y":5
         },this);
      }
      
      public static function get instance() : View_YBCGPrompt
      {
         return _instance = _instance || new View_YBCGPrompt();
      }
      
      public function show() : void
      {
         this._cbNeverTip.selected = Model_WorldBoss._YB_NOTMIT;
         if(Model_WorldBoss._YB_NOTMIT)
         {
            if(Model_WorldBoss._chuanGong >= Config_WorldBoss.MAX_CHUANGONGTIMES)
            {
               UIManager.centerBroadcast.addMsg("传功次数已满");
               this.visible = false;
            }
            if(GameUnitManager.hero.money >= Config_WorldBoss.CG_MONEY_COST)
            {
               Model_WorldBoss._YB_NOTMIT = this._cbNeverTip.selected;
               WorldBossCGMessage.CG_WB_USE_CHUANGONG(1);
               this.visible = false;
            }
            else
            {
               UIManager.centerBroadcast.addMsg("元宝不足，请及时充值");
               this.visible = false;
            }
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
         if(Model_WorldBoss._chuanGong >= Config_WorldBoss.MAX_CHUANGONGTIMES)
         {
            UIManager.centerBroadcast.addMsg("传功次数已满");
            this.hide();
            return;
         }
         if(GameUnitManager.hero.money >= Config_WorldBoss.CG_MONEY_COST)
         {
            Model_WorldBoss._YB_NOTMIT = this._cbNeverTip.selected;
            WorldBossCGMessage.CG_WB_USE_CHUANGONG(1);
            this.visible = false;
         }
         else
         {
            UIManager.centerBroadcast.addMsg("元宝不足，请及时充值");
            this.hide();
         }
      }
      
      private function hide(p:* = null) : void
      {
         this.visible = false;
         Model_WorldBoss._YB_NOTMIT = false;
      }
   }
}

