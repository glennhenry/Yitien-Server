package com.yiTian.view.modules.jiaoyi
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.data.vo.Vo_trans;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_trans_panel extends Panel
   {
      
      private var Button_FaQi:Button;
      
      private var JiaoYiRenName01_text:MyTextField;
      
      private var JiaoYiZhuTi01_text:MyTextField;
      
      private var DengDaiHuiFu_Text:MyTextField;
      
      private var Time01_text:MyTextField;
      
      public var jyItem_sava:Array = [];
      
      private var isFirstOpen:Boolean = true;
      
      public function View_trans_panel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var i:int = 0;
         var jyItem:View_jyItem = null;
         var back:DisplayObject = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":588,
            "height":422
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":24,
            "y":40,
            "width":540,
            "height":347
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":25,
            "y":41,
            "width":538,
            "height":20
         },Global.Img_Cdm);
         move = new Rectangle(0,0,back.width,38);
         ComponentUtil.getTextField(LangConfig.getWord("60149",6),this,{
            "x":55,
            "y":41,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60150",6),this,{
            "x":158,
            "y":41,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60151",6),this,{
            "x":265,
            "y":41,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60152",6),this,{
            "x":373,
            "y":41,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60153",6),this,{
            "x":477,
            "y":41,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60154",6),this,{
            "x":40,
            "y":395,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.Button_FaQi = ComponentUtil.getButton(LangConfig.getWord("70",0),"Button_Four",this,{
            "x":460,
            "y":390,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":554,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_FaQi.addEventListener(MouseEvent.CLICK,this.cilHandle);
         i = 0;
         while(i <= 9)
         {
            jyItem = new View_jyItem();
            jyItem.x = 34;
            jyItem.y = 63 + i * (95 - 63);
            addChild(jyItem);
            this.jyItem_sava.push(jyItem);
            jyItem.visible = false;
            jyItem = null;
            i++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
         {
            UIManager.bagPwdPutIn.visible = true;
            return;
         }
         super.visible = value;
         if(value)
         {
            if(this.isFirstOpen)
            {
               Utils.loadTitle("lang/ch/JiaoYi_Imgs.swf","Title_JYList",new Bitmap(),{
                  "x":214,
                  "y":5
               },this);
            }
            this.isFirstOpen = false;
            bind_target = Enum_explor.bind(Enum_explor.BTN_JIAOYI);
         }
      }
      
      private function reset_handle() : void
      {
         var i:int = 0;
         while(i < 10)
         {
            this.jyItem_sava[i].visible = false;
            i++;
         }
      }
      
      public function update_trans_item(arr:Array) : void
      {
         var voTrans:Vo_trans = null;
         var tem_jyItem:View_jyItem = null;
         this.reset_handle();
         var i:int = 0;
         while(i < arr.length)
         {
            voTrans = arr[i];
            tem_jyItem = this.jyItem_sava[i];
            tem_jyItem.visible = true;
            tem_jyItem.update(voTrans);
            i++;
         }
      }
      
      public function show_trans_send(strName:String = "") : void
      {
         if(!UIManager.trans_send_panel.visible)
         {
            UIManager.trans_send_panel.visible = true;
         }
         UIManager.trans_send_panel.setName(strName);
         if(!UIManager.bagPanel.visible)
         {
            UIManager.bagPanel.visible = true;
         }
      }
      
      private function cilHandle(e:MouseEvent) : void
      {
         this.visible = false;
         UIManager.trans_send_panel.visible = true;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

