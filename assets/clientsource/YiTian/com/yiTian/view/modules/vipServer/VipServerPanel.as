package com.yiTian.view.modules.vipServer
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.RadioButton;
   import com.ui.controls.RadioButtonGroup;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   
   public class VipServerPanel extends Panel123
   {
      
      private static const nameStr:String = "点击输入姓名";
      
      private static const phoneStr:String = "点击输入手机号码";
      
      private static const qqStr:String = "点击输入QQ号码";
      
      private static const cardStr:String = "点击输入身份证号码";
      
      private static const addressStr:String = "点击输入地址";
      
      private static const nameNullStr:String = "名字不能为空";
      
      private static const phoneNullStr:String = "手机号码不能为空";
      
      private static const qqNullStr:String = "QQ号码不能为空";
      
      private static const cardNullStr:String = "身份证号码不能为空";
      
      private static const addressNullStr:String = "地址不能为空";
      
      private static const nameConst:String = "NAME";
      
      private static const phoneConst:String = "PHONE";
      
      private static const qqConst:String = "QQ";
      
      private static const cardConst:String = "CARD";
      
      private static const addressConst:String = "ADDRESS";
      
      private var bg:DisplayObject;
      
      private var txtName:MyTextField;
      
      private var txtPhone:MyTextField;
      
      private var txtQQ:MyTextField;
      
      private var txtCard:MyTextField;
      
      private var txtAddress:MyTextField;
      
      private var btnOk:Button;
      
      private var gou:Bitmap;
      
      private var giftIcon:Bitmap;
      
      private var isCancel:Boolean = false;
      
      private var qq:String = "800079096";
      
      private var rbg:RadioButtonGroup;
      
      private var rb_yb:RadioButton;
      
      private var rb_yl:RadioButton;
      
      private var sexType:int;
      
      private var iconArr:Array = [43001,43011,46353,46221];
      
      public function VipServerPanel()
      {
         super();
         regResource("lang/ch/BJWH.swf","BJWHdm");
      }
      
      public static function get instance() : VipServerPanel
      {
         return Singleton.getInstance(VipServerPanel);
      }
      
      override protected function initUI2() : void
      {
         this.bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":357,
            "height":403
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":309,
            "height":353
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_BJWH",this,{
            "x":98,
            "y":3
         },Global.BJWHdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":33,
            "y":130,
            "width":291,
            "height":210
         },Global.Img_Cdm);
         var sprite:Sprite = new Sprite();
         addChild(sprite);
         this.giftIcon = ComponentUtil.getBitmap("Text_NTWJ",sprite,{
            "x":34,
            "y":50
         },Global.BJWHdm);
         var des:MyTextField = ComponentUtil.getTextField("",this,{
            "x":44,
            "y":147,
            "color":15856113,
            "size":12,
            "leading":18
         });
         des.htmlText = "姓名:\n性别:\n手机:\nQQ:\n身份证:\n联系地址:\n";
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":120,
            "y":146,
            "width":194,
            "height":23
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":120,
            "y":210,
            "width":194,
            "height":23
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":120,
            "y":242,
            "width":194,
            "height":23
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":120,
            "y":274,
            "width":194,
            "height":23
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":120,
            "y":306,
            "width":194,
            "height":23
         },Global.Img_Cdm);
         this.txtName = ComponentUtil.getTextField(nameStr,this,{
            "x":123,
            "y":147,
            "color":16776960,
            "size":12,
            "leading":0,
            "type":TextFieldType.INPUT,
            "realWidth":142,
            "realHeight":18,
            "maxChars":100
         });
         this.txtName.name = nameConst;
         this.txtPhone = ComponentUtil.getTextField(phoneStr,this,{
            "x":123,
            "y":212,
            "color":16776960,
            "size":12,
            "leading":0,
            "type":TextFieldType.INPUT,
            "realWidth":142,
            "realHeight":18,
            "maxChars":11
         });
         this.txtPhone.restrict = "0-9";
         this.txtPhone.name = phoneConst;
         this.txtQQ = ComponentUtil.getTextField(qqStr,this,{
            "x":123,
            "y":242,
            "color":16776960,
            "size":12,
            "leading":0,
            "type":TextFieldType.INPUT,
            "realWidth":142,
            "realHeight":18,
            "maxChars":13
         });
         this.txtQQ.restrict = "0-9";
         this.txtQQ.name = qqConst;
         this.txtCard = ComponentUtil.getTextField(cardStr,this,{
            "x":123,
            "y":273,
            "color":16776960,
            "size":12,
            "leading":0,
            "type":TextFieldType.INPUT,
            "realWidth":142,
            "realHeight":18,
            "maxChars":100
         });
         this.txtCard.name = cardConst;
         this.txtAddress = ComponentUtil.getTextField(addressStr,this,{
            "x":123,
            "y":306,
            "color":16776960,
            "size":12,
            "leading":0,
            "type":TextFieldType.INPUT,
            "realWidth":142,
            "realHeight":18,
            "maxChars":100
         });
         this.txtAddress.name = addressConst;
         this.gou = ComponentUtil.getBitmap("BG_Gou",this,{
            "x":286,
            "y":149
         },Global.BJWHdm);
         this.gou.visible = false;
         this.btnOk = ComponentUtil.getButton("","BT_QD",this,{
            "x":124,
            "y":346,
            "textColor":16771436
         },Global.BJWHdm);
         this.btnOk.addEventListener(MouseEvent.CLICK,this.onOk);
         move = new Rectangle(0,0,this.bg.width,38);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":320,
            "y":6,
            "textColor":16771436,
            "callBack":this.hide
         },Global.Img_Cdm);
         this.addRadioButton();
         this.txtName.addEventListener(FocusEvent.FOCUS_IN,this.focusIn);
         this.txtName.addEventListener(FocusEvent.FOCUS_OUT,this.focusOut);
         this.txtPhone.addEventListener(FocusEvent.FOCUS_IN,this.focusIn);
         this.txtPhone.addEventListener(FocusEvent.FOCUS_OUT,this.focusOut);
         this.txtQQ.addEventListener(FocusEvent.FOCUS_IN,this.focusIn);
         this.txtQQ.addEventListener(FocusEvent.FOCUS_OUT,this.focusOut);
         this.txtCard.addEventListener(FocusEvent.FOCUS_IN,this.focusIn);
         this.txtCard.addEventListener(FocusEvent.FOCUS_OUT,this.focusOut);
         this.txtAddress.addEventListener(FocusEvent.FOCUS_IN,this.focusIn);
         this.txtAddress.addEventListener(FocusEvent.FOCUS_OUT,this.focusOut);
      }
      
      private function focusIn(e:FocusEvent) : void
      {
         var tt:MyTextField = e.target as MyTextField;
         tt.color = 16776960;
         switch(tt.name)
         {
            case nameConst:
               if(tt.text == nameStr || tt.text == nameNullStr)
               {
                  tt.text = "";
                  this.gou.visible = false;
                  break;
               }
               this.gou.visible = true;
               break;
            case phoneConst:
               if(tt.text == phoneStr || tt.text == phoneNullStr)
               {
                  tt.text = "";
               }
               break;
            case qqConst:
               if(tt.text == qqStr || tt.text == qqNullStr)
               {
                  tt.text = "";
               }
               break;
            case cardConst:
               if(tt.text == cardStr || tt.text == cardNullStr)
               {
                  tt.text = "";
               }
               break;
            case addressConst:
               if(tt.text == addressStr || tt.text == addressNullStr)
               {
                  tt.text = "";
               }
         }
      }
      
      private function focusOut(e:FocusEvent) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         switch(tf.name)
         {
            case nameConst:
               if(tf.text == "")
               {
                  tf.text = nameStr;
                  this.gou.visible = false;
                  break;
               }
               this.gou.visible = true;
               break;
            case phoneConst:
               if(tf.text == "")
               {
                  tf.text = phoneStr;
               }
               break;
            case qqConst:
               if(tf.text == "")
               {
                  tf.text = qqStr;
               }
               break;
            case cardConst:
               if(tf.text == "")
               {
                  tf.text = cardStr;
               }
               break;
            case addressConst:
               if(tf.text == "")
               {
                  tf.text = addressStr;
               }
         }
      }
      
      private function onOk(e:MouseEvent) : void
      {
         if(this.txtName.text == nameStr || this.txtName.text == "" || this.txtName.text == nameNullStr)
         {
            this.txtName.text = nameNullStr;
            this.txtName.color = 16711680;
            this.isCancel = true;
         }
         if(this.txtPhone.text == phoneStr || this.txtPhone.text == "" || this.txtPhone.text == phoneNullStr)
         {
            this.txtPhone.text = phoneNullStr;
            this.txtPhone.color = 16711680;
            this.isCancel = true;
         }
         if(this.txtQQ.text == qqStr || this.txtQQ.text == "" || this.txtQQ.text == qqNullStr)
         {
            this.txtQQ.text = qqNullStr;
            this.txtQQ.color = 16711680;
            this.isCancel = true;
         }
         if(this.txtCard.text == cardStr || this.txtCard.text == "" || this.txtCard.text == cardNullStr)
         {
            this.txtCard.text = cardNullStr;
            this.txtCard.color = 16711680;
            this.isCancel = true;
         }
         if(this.txtAddress.text == addressStr || this.txtAddress.text == "" || this.txtAddress.text == addressNullStr)
         {
            this.txtAddress.text = addressNullStr;
            this.txtAddress.color = 16711680;
            this.isCancel = true;
         }
         if(this.isCancel == true)
         {
            this.isCancel = false;
            return;
         }
         if(this.txtPhone.text.length < 11)
         {
            UIManager.centerBroadcast.addMsg("手机号码必须为11位数");
            return;
         }
         Global.delegate.dosomething(VipServerAlert.instance,function():void
         {
            VipServerAlert.instance.show(txtName.text,sexType,txtPhone.text,txtQQ.text,txtCard.text,txtAddress.text);
         });
      }
      
      private function addRadioButton() : void
      {
         this.rbg = new RadioButtonGroup();
         this.rbg.direction = RadioButtonGroup.HORIZONTAL;
         this.rbg.space = 40;
         this.rbg.x = 120;
         this.rbg.y = 180;
         this.rb_yl = ComponentUtil.getRadioButton("男","CheckBox",this.rbg,{"value":"男"});
         this.rb_yb = ComponentUtil.getRadioButton("女","CheckBox",this.rbg,{"value":"女"});
         this.rbg.selectedItem = this.rb_yb;
         this.rbg.addEventListener(RadioButtonGroup.SELECTED_CHANGE,function():void
         {
            var value:Object = null;
            if(Boolean(rbg.selectedItem))
            {
               value = rbg.selectedItem.value;
               if(value == "男")
               {
                  sexType = 0;
               }
               else
               {
                  sexType = 1;
               }
            }
         });
         addChild(this.rbg);
      }
      
      public function flyIcon() : void
      {
         var dir:String = null;
         var disPoint:Point = null;
         var p:Point = null;
         var bm:Bitmap2 = null;
         disPoint = UIManager.mainMenu.getbagPoint();
         p = this.localToGlobal(new Point(this.giftIcon.x,this.giftIcon.y));
         var i:int = 0;
         while(i < 4)
         {
            dir = "resource/image/icon/" + this.iconArr[i] + ".png";
            bm = new Bitmap2();
            bm.load(dir);
            bm.x = p.x + i * 65;
            bm.y = p.y + 25;
            GameScene.upUILayer.addChild(bm);
            Tween.to(bm,2500,{
               "x":[bm.x,disPoint.x],
               "y":[bm.y,disPoint.y]
            },function(bm:Bitmap2):void
            {
               if(Boolean(bm.parent))
               {
                  bm.parent.removeChild(bm);
               }
            },null,Tween.SIN);
            i++;
         }
      }
      
      public function show() : void
      {
         visible = true;
      }
      
      public function hide(prm:* = null) : void
      {
         visible = false;
      }
   }
}

