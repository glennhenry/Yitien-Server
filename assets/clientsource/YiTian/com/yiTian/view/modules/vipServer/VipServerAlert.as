package com.yiTian.view.modules.vipServer
{
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.net.message.cg.VIPCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.system.System;
   
   public class VipServerAlert extends Panel123
   {
      
      private static const qq:String = "800079096";
      
      private var txtName:MyTextField;
      
      private var namePlayer:String;
      
      private var sexType:int;
      
      private var txtPhone:String;
      
      private var txtQQ:String;
      
      private var txtCard:String;
      
      private var txtAddress:String;
      
      public function VipServerAlert()
      {
         super();
         regResource("lang/ch/BJWH.swf","BJWHdm");
      }
      
      public static function get instance() : VipServerAlert
      {
         return Singleton.getInstance(VipServerAlert);
      }
      
      override protected function initUI2() : void
      {
         var copyTxt:MyTextField = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":368,
            "height":239
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":319,
            "height":189
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":32,
            "y":47,
            "width":302,
            "height":135
         },Global.Img_Cdm);
         this.txtName = ComponentUtil.getTextField("",this,{
            "x":41,
            "y":57,
            "color":15856113,
            "size":12,
            "leading":10
         });
         ComponentUtil.getTextField("企业QQ:" + qq,this,{
            "x":41,
            "y":143,
            "color":16711680,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("联系电话:020-29285332",this,{
            "x":193,
            "y":143,
            "color":16711680,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Title_WXTS",this,{
            "x":104,
            "y":5
         },Global.BJWHdm);
         ComponentUtil.getButton("","Button_Orange",this,{
            "x":84,
            "y":190,
            "textColor":16771436,
            "callBack":this.onClick
         },Global.Img_Cdm);
         ComponentUtil.getTextField("信息准确",this,{
            "x":94,
            "y":193,
            "color":16184781,
            "size":12,
            "leading":0
         });
         ComponentUtil.getButton("","Button_Four",this,{
            "x":204,
            "y":190,
            "textColor":16771436,
            "callBack":this.hide
         },Global.Img_Cdm);
         ComponentUtil.getTextField("重新填写",this,{
            "x":215,
            "y":193,
            "color":16184781,
            "size":12,
            "leading":0
         });
         copyTxt = ComponentUtil.getTextField("",this,{
            "x":155,
            "y":143,
            "color":65280,
            "size":12,
            "leading":0
         });
         copyTxt.htmlText = "<font color=\'" + ColorConstant.getColorStr(ColorConstant.GREEN) + "\'><u><a href=\'event:ok\'>复制</a></u></font>";
         copyTxt.mouseEnabled = true;
         copyTxt.addEventListener(TextEvent.LINK,this.onLink);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":331,
            "y":6,
            "textColor":16771436,
            "callBack":this.hide
         },Global.Img_Cdm);
      }
      
      private function onLink(e:TextEvent) : void
      {
         System.setClipboard(qq);
      }
      
      private function onClick(e:MouseEvent) : void
      {
         VIPCGMessage.CG_SAVE_VIP_SERVER_INFO(this.namePlayer,this.sexType,this.txtPhone,this.txtQQ,this.txtCard,this.txtAddress);
         this.hide();
      }
      
      public function show(name:String, sexType:int, txtPhone:String, txtQQ:String, txtCard:String, txtAddress:String) : void
      {
         this.namePlayer = name;
         this.sexType = sexType;
         this.txtPhone = txtPhone;
         this.txtQQ = txtQQ;
         this.txtCard = txtCard;
         this.txtAddress = txtAddress;
         visible = true;
         var str:String = (GameUnitManager.hero.sex == 1 ? "这位少侠" : "这位侠女") + "您填写的信息资料中务必填写正确。因为这可\n能会关系到礼品发送是否成功。" + "请再次确认填写的资料\n是否正确。";
         this.txtName.htmlText = str;
      }
      
      public function hide(prm:* = null) : void
      {
         visible = false;
      }
   }
}

