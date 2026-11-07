package com.yiTian.view.modules.banhui
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.BangCGMessage;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   
   public class View_bangEvent extends Panel
   {
      
      private var Button_PageUp:Button;
      
      private var Button_PageDown:Button;
      
      private var PageNumber_text:MyTextField;
      
      public var event_items:View_bangEventItem;
      
      public var event_items_arr:Array = [];
      
      public var curPage:int = 1;
      
      public var totalPage:int = 1;
      
      public var partyId:Number;
      
      private var nowItem:View_bangEventItem;
      
      private var bg:Bitmap;
      
      public function View_bangEvent()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var i:int = 0;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":530,
            "height":430
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":482,
            "height":380
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":30,
            "y":48,
            "width":470,
            "height":342
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":32,
            "y":50,
            "width":466,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":221,
            "y":394,
            "width":100,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60006",6),this,{
            "x":60,
            "y":50,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60007",6),this,{
            "x":420,
            "y":50,
            "color":16764206,
            "size":12,
            "leading":0
         });
         move = new Rectangle(0,0,568,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":492,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_PageDown = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":198,
            "y":394,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_PageUp = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":323,
            "y":394,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_PageUp.name = "add";
         this.Button_PageDown.name = "minus";
         this.PageNumber_text = ComponentUtil.getTextField("000/000",this,{
            "x":240,
            "y":394,
            "color":16764206,
            "size":12,
            "realWidth":60,
            "leading":0
         });
         this.PageNumber_text.autoSize = TextFieldAutoSize.CENTER;
         i = 0;
         while(i < 10)
         {
            this.event_items = new View_bangEventItem();
            addChild(this.event_items);
            this.event_items.x = 32;
            this.event_items.y = 70 + 32 * i;
            this.event_items_arr.push(this.event_items);
            this.event_items.addEventListener(MouseEvent.CLICK,this.choseHandle);
            this.event_items.visible = false;
            this.event_items = null;
            i++;
         }
         this.Button_PageUp.addEventListener(MouseEvent.CLICK,this.pageChangedHandle);
         this.Button_PageDown.addEventListener(MouseEvent.CLICK,this.pageChangedHandle);
      }
      
      private function pageChangedHandle(e:MouseEvent) : void
      {
         var temBtn:Button = e.target as Button;
         if(temBtn.name == "minus")
         {
            --this.curPage;
            if(this.curPage < 1)
            {
               this.curPage = 1;
            }
         }
         else if(temBtn.name == "add")
         {
            ++this.curPage;
            if(this.curPage > this.totalPage)
            {
               this.curPage = this.totalPage;
            }
         }
         BangCGMessage.CG_BANG_EVENT_CHECK(this.partyId,this.curPage);
      }
      
      public function choseHandle(e:MouseEvent) : void
      {
         var temItem:View_bangEventItem = e.target as View_bangEventItem;
         if(this.nowItem == temItem)
         {
            return;
         }
         if(Boolean(this.nowItem))
         {
            this.nowItem.choose = false;
         }
         this.nowItem = temItem;
         this.nowItem.choose = true;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!Global.Bang_Imgsdm)
            {
               SingleLoader.add("lang/ch/Bang_Imgs.swf",function(info:Object):void
               {
                  Global.Bang_Imgsdm = info.applicationDomain;
                  showTitle();
               });
            }
            else if(!this.bg)
            {
               this.showTitle();
            }
         }
      }
      
      private function showTitle() : void
      {
         this.bg = ComponentUtil.getBitmap("Title_BangShiJian",this,{
            "x":185,
            "y":5
         },Global.Bang_Imgsdm);
      }
      
      public function update(cur_page:int, total_page:int, size:int, event_Arr:Array) : void
      {
         var item:View_bangEventItem = null;
         var i:int = 0;
         var item_event:View_bangEventItem = null;
         this.totalPage = total_page;
         this.PageNumber_text.text = String(this.curPage) + "/" + String(total_page);
         for each(item in this.event_items_arr)
         {
            item.visible = false;
         }
         i = 0;
         while(i < size)
         {
            item_event = this.event_items_arr[i];
            item_event.visible = true;
            item_event.update(event_Arr[i]);
            i++;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

