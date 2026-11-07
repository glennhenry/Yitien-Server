package com.yiTian.view.modules.panel
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_item_type;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BagCGMessage;
   import com.yiTian.net.message.cg.ChunJieNianGaoCGMessage;
   import com.yiTian.net.message.cg.DepotCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.View_UI_modal;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.guaji.Model_guajiInfo;
   import com.yiTian.view.modules.shenBing.ShenBingUtil;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFieldType;
   import flash.text.TextFormatAlign;
   
   public class View_num_valuable extends View_UI_modal
   {
      
      public static const BAG_DEPOT:int = 1;
      
      public static const DEPOT_BAG:int = 2;
      
      public static const BAG_COMPOSE:int = 3;
      
      public static const BAG_USE_ITEM:int = 4;
      
      private static const INDENT:int = 25;
      
      private static const INDENT_Y:int = 10;
      
      private var tf_tip:MyTextField;
      
      private var bmp_iconFrame:Bitmap;
      
      private var bmp_iconBg:Bitmap;
      
      private var bmp_icon:Bitmap;
      
      private var btn_add:Button;
      
      private var btn_subtract:Button;
      
      private var tf_count:MyTextField;
      
      private var btn_ok:Button;
      
      private var btn_cancel:Button;
      
      private var vo:Vo_valuable;
      
      private var type:int;
      
      private var gridId_interactive:int;
      
      private var max_count:int;
      
      private var tf:MyTextField;
      
      public function View_num_valuable()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var closeB:Button;
         var str:String;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":308,
            "height":170
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":260,
            "height":120
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":164,
            "y":80,
            "width":50,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_PiLiang",this,{
            "x":74,
            "y":5
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60244",6),this,{
            "x":141,
            "y":60,
            "color":11904647,
            "size":12,
            "leading":0
         });
         closeB = ComponentUtil.getButton("","Button_Close",this,{
            "x":274,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         closeB.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            visible = false;
         });
         str = HtmlUtil.font(LangConfig.getWord("897",0),ColorConstant.getColorStr(ColorConstant.YELLOW_SAND),14);
         this.bmp_iconFrame = Utils.getLoadBitmap(View_Grid.GRID_OPEN,this.bmp_icon);
         addChild(this.bmp_iconFrame);
         this.bmp_iconBg = new Bitmap();
         addChild(this.bmp_iconBg);
         this.bmp_icon = new Bitmap();
         addChild(this.bmp_icon);
         this.bmp_iconBg.x = this.bmp_icon.x = 82;
         this.bmp_iconBg.y = this.bmp_icon.y = 65.6;
         this.bmp_iconFrame.x = this.bmp_iconBg.x - 3;
         this.bmp_iconFrame.y = this.bmp_iconBg.y - 3;
         this.btn_subtract = this.btn_add = ComponentUtil.getButton("","Tree_Close",this,{
            "x":218,
            "y":83,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_subtract = ComponentUtil.getButton("","Tree_Open",this,{
            "x":144,
            "y":83,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_add.addEventListener(MouseEvent.CLICK,this.CLICK_ADD);
         this.btn_subtract.addEventListener(MouseEvent.CLICK,this.CLICK_SUBTRACT);
         this.tf_count = ComponentUtil.getTextField("",this,{
            "x":170,
            "y":82,
            "color":16184781,
            "realWidth":42
         });
         this.tf_count.type = TextFieldType.INPUT;
         this.tf_count.align = TextFormatAlign.CENTER;
         this.tf_count.addEventListener(Event.CHANGE,this.CHANGE);
         this.tf_count.maxChars = 3;
         this.tf_count.restrict = "0-9";
         this.btn_ok = ComponentUtil.getButton(LangConfig.getWord("6",0),"Button_Four",this,{
            "x":60,
            "y":120,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_cancel = ComponentUtil.getButton(LangConfig.getWord("5",0),"Button_Four",this,{
            "x":178,
            "y":120,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_ok.addEventListener(MouseEvent.CLICK,this.CLICK_BTN_OK);
         this.btn_cancel.addEventListener(MouseEvent.CLICK,this.CLICK_BTN_CANCEL);
      }
      
      public function Show($vo:Vo_valuable, $type:int, $gridId_interactive:int = 0) : void
      {
         var vo_item:Vo_item = null;
         if(Global.pf == "qqgame")
         {
            if($vo.id == 46415)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60240",6));
               return;
            }
         }
         else if($vo.id == 46463)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("60241",6));
            return;
         }
         visible = true;
         this.vo = $vo;
         this.type = $type;
         this.gridId_interactive = $gridId_interactive;
         Utils.getLoadBitmap("resource/image/icon/" + this.vo.str_icon + ".png",this.bmp_icon);
         Utils.getLoadBitmap("resource/image/iconBg/" + this.vo.bgIndex + ".png",this.bmp_iconBg);
         if(this.type != BAG_DEPOT)
         {
            if(this.type != DEPOT_BAG)
            {
               if(this.type == BAG_COMPOSE)
               {
                  vo_item = this.vo as Vo_item;
                  this.max_count = this.vo.count / vo_item.num_combining;
                  this.tf_count.text = "1";
                  return;
               }
               if(this.type == BAG_USE_ITEM)
               {
               }
            }
         }
         this.max_count = this.vo.count;
         this.tf_count.text = String(this.max_count);
      }
      
      private function CHANGE(e:Event) : void
      {
         if(int(this.tf_count.text) > this.max_count)
         {
            this.tf_count.text = this.max_count.toString();
         }
      }
      
      private function CLICK_ADD(e:MouseEvent) : void
      {
         var count:int = int(this.tf_count.text);
         if(count < this.max_count)
         {
            this.tf_count.text = (++count).toString();
         }
      }
      
      private function CLICK_SUBTRACT(e:MouseEvent) : void
      {
         var count:int = int(this.tf_count.text);
         if(count > 1)
         {
            this.tf_count.text = (--count).toString();
         }
      }
      
      private function CLICK_BTN_CANCEL(e:MouseEvent) : void
      {
         visible = false;
      }
      
      private function CLICK_BTN_OK(e:MouseEvent) : void
      {
         visible = false;
         if(this.vo.type == 200 && this.type == BAG_USE_ITEM)
         {
            UIManager.heroHead.buffItemUse(this.vo as Vo_item,int(this.tf_count.text));
            return;
         }
         if(this.vo.id >= 46615 && this.vo.id <= 46618 && this.type == 0)
         {
            Model_guajiInfo.getInstance().useGjdItem(this.vo as Vo_item,int(this.tf_count.text));
            return;
         }
         if(Data_lib.item[this.vo.id][Enum_lib_item.TYPE] == Enum_item_type.FISH)
         {
            if(!GameUnitManager.hero.partyId && Model_bang.partyType == 0)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("750",0));
            }
            else
            {
               BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,this.vo.gridId,int(this.tf_count.text));
            }
            return;
         }
         if(this.type == BAG_DEPOT)
         {
            DepotCGMessage.CG_DEPOT_SWAP(DepotCGMessage.BAG_DEPOT,this.vo.gridId,this.gridId_interactive,int(this.tf_count.text));
         }
         else if(this.type == DEPOT_BAG)
         {
            DepotCGMessage.CG_DEPOT_SWAP(DepotCGMessage.DEPOT_BAG,this.vo.gridId,this.gridId_interactive,int(this.tf_count.text));
         }
         else if(this.type == BAG_COMPOSE)
         {
            BagCGMessage.CG_BAG_COMPOSE(this.vo.gridId,int(this.tf_count.text));
         }
         else if(this.type == BAG_USE_ITEM)
         {
            if(this.vo.id == 46620 || this.vo.id == 46621 || this.vo.id == 46622 || this.vo.id == 46623 || this.vo.id == 46624 || this.vo.id == 46625 || this.vo.id == 46626 || this.vo.id == 46627)
            {
               if(!UIManager.layInPill)
               {
                  UIManager.layInPill = new View_layIn_pill();
                  UIManager.layInPill.init();
               }
               UIManager.layInPill.visible = true;
               UIManager.layInPill.update(this.vo.id,int(this.tf_count.text),this.vo.str_name,this.vo.color,this.vo.gridId);
               return;
            }
            if(this.vo.id == ShenBingUtil.SHENBING_CHIP_ID || this.vo.id == ShenBingUtil.YUPAI_ID)
            {
               ShenBingUtil.askOpenShenBingPanel();
               return;
            }
            if(this.vo.id == 45384)
            {
               ChunJieNianGaoCGMessage.CG_ChunJieNianGao_EAT(int(this.tf_count.text),this.vo.gridId);
               return;
            }
            BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,this.vo.gridId,int(this.tf_count.text));
         }
      }
   }
}

