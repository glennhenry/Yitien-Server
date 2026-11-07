package com.yiTian.view.modules.banhui.bBindQQGroup
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BangCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.qqPackage.QQGroupStaticFunctions;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   
   public class BindPan extends Panel123
   {
      
      private var bindBtn:Button;
      
      private var askBtn:Button;
      
      private var tongBuBtn:Button;
      
      private var jieChuBtn:Button;
      
      private var checkBox:CheckBox;
      
      private var tf:MyTextField;
      
      private var QQGroup:MyTextField;
      
      private var tongBuEnable:Boolean = true;
      
      public function BindPan()
      {
         super();
         regResource("lang/ch/QQBH.swf","QQBHdm");
      }
      
      public static function get instance() : BindPan
      {
         return Singleton.getInstance(BindPan);
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":448,
            "height":271
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":398,
            "height":223
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":52,
            "width":374,
            "height":174
         },Global.QQBHdm);
         ComponentUtil.getBitmap("Back_NRD",this,{
            "x":44,
            "y":104
         },Global.QQBHdm);
         this.jieChuBtn = ComponentUtil.getButton("","Button_Four",this,{
            "x":262,
            "y":69,
            "textColor":16771436
         },Global.Img_Cdm);
         this.bindBtn = ComponentUtil.getButton("","Button_Four",this,{
            "x":83,
            "y":111,
            "textColor":16771436
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":412,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         CloseButton.addEventListener(MouseEvent.CLICK,this.closeHandler);
         ComponentUtil.getButton("","Button_Quest",this,{
            "x":386,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Back_NRD",this,{
            "x":44,
            "y":145
         },Global.QQBHdm);
         this.askBtn = ComponentUtil.getButton("","Button_Four",this,{
            "x":83,
            "y":152,
            "textColor":16771436
         },Global.Img_Cdm);
         ComponentUtil.getTextField("帮会Q群：",this,{
            "x":95,
            "y":71,
            "color":16777215,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("绑定QQ群",this,{
            "x":90,
            "y":114,
            "color":16773818,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("帮众邀请",this,{
            "x":93,
            "y":155,
            "color":16773818,
            "size":12,
            "leading":0
         });
         this.tf = ComponentUtil.getTextField("解除绑定",this,{
            "x":272,
            "y":72,
            "color":16773818,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("为帮会绑定QQ群，方便成员之间交流。",this,{
            "x":175,
            "y":117,
            "color":16043313,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("邀请帮会成员加入帮会QQ群。",this,{
            "x":176,
            "y":158,
            "color":16043313,
            "size":12,
            "leading":0
         });
         this.checkBox = ComponentUtil.getCheckBox("","CheckBox01",this,{
            "x":84,
            "y":194,
            "color":16772287
         },Global.Img_Cdm);
         this.checkBox.selected = true;
         ComponentUtil.getTextField("帮会聊天同步至QQ群",this,{
            "x":106,
            "y":192,
            "color":16777215,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Back_QHD",this,{
            "x":150,
            "y":71
         },Global.QQBHdm);
         this.QQGroup = ComponentUtil.getTextField("",this,{
            "x":150,
            "y":71,
            "color":16777215,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Title_QQBH",this,{
            "x":144,
            "y":6
         },Global.QQBHdm);
         this.bindBtn.callBack = this.bindHandler;
         this.askBtn.callBack = this.askHanler;
         this.askBtn.enabled = false;
         this.QQGroup.type = TextFieldType.INPUT;
         this.QQGroup.realWidth = 100;
         this.QQGroup.realHeight = 20;
         this.QQGroup.restrict = "0-9";
         this.QQGroup.maxChars = 9;
         this.jieChuBtn.callBack = this.jieChuHandler;
         move = new Rectangle(0,0,400,60);
         initDynamicView();
      }
      
      private function bindHandler(e:MouseEvent) : void
      {
         var unionid:String = this.QQGroup.text;
         QQGroupStaticFunctions.createQQGroup(unionid,Model_bang.partyInfo.party_name);
      }
      
      private function askHanler(e:MouseEvent) : void
      {
         this.askBtn.enabled = false;
         BangCGMessage.CG_ASK_IN_QQGROUP();
      }
      
      private function jieChuHandler(e:MouseEvent) : void
      {
         BangCGMessage.CG_BANG_QQGROUP_SAVE("","",0);
      }
      
      private function closeHandler(e:MouseEvent) : void
      {
         BangCGMessage.CG_BANG_CHANGED_ANNOUNCEMENT(2,GameUnitManager.hero.partyId,this.QQGroup.text);
         if(this.bindBtn.enabled == false)
         {
            if(this.checkBox.selected == true)
            {
               BangCGMessage.CG_TONGBU_TO_QQGROUP(1);
               UIManager.centerBroadcast.addMsg("帮会聊天成功同步至QQ群");
            }
            else
            {
               UIManager.centerBroadcast.addMsg("帮会聊天未同步到QQ群");
               BangCGMessage.CG_TONGBU_TO_QQGROUP(0);
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg("未绑定QQ群");
         }
      }
      
      public function show(result:int, yaoQing:int, str:String) : void
      {
         Utils.print(result,yaoQing,str,"what\'s wrong!??");
         if(visible == false)
         {
            visible = true;
         }
         var _str:String = str;
         var _result:int = result;
         var isEnable:int = yaoQing;
         this.QQGroup.text = _str;
         if(_result == 1)
         {
            this.jieChuBtn.enabled = true;
            this.bindBtn.enabled = false;
            this.tongBuEnable = true;
            this.QQGroup.type = TextFieldType.DYNAMIC;
            if(isEnable == 0)
            {
               this.askBtn.enabled = true;
            }
         }
         else
         {
            this.QQGroup.type = TextFieldType.INPUT;
            this.jieChuBtn.enabled = false;
            this.bindBtn.enabled = true;
            this.askBtn.enabled = false;
            this.tongBuEnable = false;
         }
      }
   }
}

