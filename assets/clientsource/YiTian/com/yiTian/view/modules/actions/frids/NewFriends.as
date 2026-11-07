package com.yiTian.view.modules.actions.frids
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.QplusShareCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.Panel123;
   import flash.events.TextEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Rectangle;
   
   public class NewFriends extends Panel123
   {
      
      public static var inerSend:Boolean = false;
      
      private var back:ScaleBitmap;
      
      private var friVec:Vector.<FItems> = new Vector.<FItems>(7);
      
      public function NewFriends()
      {
         super();
         regResource("lang/ch/Invite_Imgs.swf","Invite_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         var i:int;
         var t:MyTextField = null;
         var tt:MyTextField = null;
         var fi:FItems = null;
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":620,
            "height":445
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":39,
            "width":572,
            "height":395
         },Global.Img_Cdm);
         move = new Rectangle(0,0,620,38);
         ComponentUtil.getTextField("邀请QQ好友玩倚天，他爽你爽一起爽。",this,{
            "x":34,
            "y":50,
            "color":16773818,
            "size":16,
            "leading":0
         });
         ComponentUtil.getButton("邀请好友","Button_Orange",this,{
            "x":500,
            "y":50,
            "textColor":16184781,
            "callBack":function():void
            {
               inviteFirendHandle();
            }
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":34,
            "y":85,
            "width":552,
            "height":340
         },Global.Img_Cdm);
         t = ComponentUtil.getTextField("",this,{
            "x":50,
            "y":400,
            "color":458496,
            "size":12,
            "leading":0
         });
         t.htmlText = HtmlUtil.underLine("详细规则");
         t.mouseEnabled = true;
         TipManager.bind(t,HtmlUtil.font("如何成为倚天Q友","#f9ff00",14) + "\n1.通过邀请好友按钮向QQ好友发送游戏邀请\n2.您的好友通过点击系统弹出消息进入倚天服务器选择页面，并选择您所在的服务器进入（必须）\n3.创建角色并进入游戏，对方会自动成为您的倚天Q友");
         tt = ComponentUtil.getTextField("",this,{
            "x":155,
            "y":400,
            "color":12877056,
            "size":12,
            "leading":0
         });
         tt.mouseEnabled = true;
         tt.htmlText = "邀请的QQ好友进入该区游戏后会自动成为您的倚天Q友，可在" + HtmlUtil.font(HtmlUtil.underLine(HtmlUtil.link("好友面板","ss")),"#04ff00") + "中查看";
         tt.addEventListener(TextEvent.LINK,function():void
         {
            UIManager.mainMenu.frieHandle();
         });
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":586,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         initDynamicView();
         i = 0;
         while(i < this.friVec.length)
         {
            fi = new FItems(i + 1);
            addChild(fi);
            ComponentUtil.setPropertie(fi,{
               "x":39,
               "y":90 + 44 * i
            });
            this.friVec[i] = fi;
            i++;
         }
         ComponentUtil.getBitmap("Title_Invite",this,{
            "x":230,
            "y":5
         },Global.Invite_Imgsdm);
      }
      
      private function inviteFirendHandle() : void
      {
         ExternalInterface.call("inviteFriend");
         if(inerSend)
         {
            QplusShareCGMessage.CG_INVITE_RESULT();
         }
      }
      
      public function updateStatus() : void
      {
         var item:FItems = null;
         var s:int = 0;
         var i:int = 0;
         while(i < this.friVec.length)
         {
            item = this.friVec[i];
            s = int(Model_FI.getStatus[i]);
            item.status = s;
            i++;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.back.width) / 2;
         y = (Global.stage.stageHeight - this.back.height) / 2;
      }
   }
}

