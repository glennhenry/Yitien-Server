package com.yiTian.view.modules.shenMiShop
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.list.List;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_sms;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.SMSCGMessage;
   import com.yiTian.view.Panel;
   import flash.geom.Rectangle;
   
   public class View_search extends Panel
   {
      
      private static var isFirstOpen:Boolean = true;
      
      private var YuanBao_text:MyTextField;
      
      private var searchItem:View_searchItem;
      
      private var itemArr:Array = [[41001,1,101,1,1000,1],[41002,1,102,2,2000,2],[41003,1,103,3,3000,3],[41004,1,104,4,4000,4],[41005,1,105,5,5000,5],[41006,1,106,6,6000,6],[41007,1,107,7,7000,7],[41008,1,108,8,8000,8],[41009,1,109,9,9000,9],[41011,1,110,10,10000,10],[41012,1,111,11,20000,11],[41013,1,112,12,30000,12],[41014,1,113,13,40000,13],[90100,2,200,1,111,1],[90101,2,201,1,222,1],[90102,2,202,1,333,1],[90103,2,203,1,444,1],[90105,2,204,1,555,1],[90106,2,205,1,666,1],[90107,2,206,1,777,1],[90108,2,207,1,888,1]];
      
      private var isSetRemain:Boolean = false;
      
      public var list:List;
      
      public var data:Array;
      
      public function View_search()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":668,
            "height":475
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":29,
            "y":45,
            "width":610,
            "height":404
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":30,
            "y":46,
            "width":608,
            "height":28
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60280",6),this,{
            "x":34,
            "y":450,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60168",6),this,{
            "x":95,
            "y":50,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60283",6),this,{
            "x":210,
            "y":50,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60148",6),this,{
            "x":288,
            "y":50,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60284",6),this,{
            "x":455,
            "y":50,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60023",6),this,{
            "x":550,
            "y":50,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60285",6),this,{
            "x":370,
            "y":50,
            "color":16764206,
            "size":12,
            "leading":0
         });
         move = new Rectangle(0,0,617,38);
         this.YuanBao_text = ComponentUtil.getTextField(LangConfig.getWord("24",0),this,{
            "x":520,
            "y":450,
            "color":16764206,
            "size":14
         });
         this.YuanBao_text.textColor = 16383744;
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":634,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.addList();
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.YuanBao_text.text = LangConfig.getWord("25",0) + String(GameUnitManager.hero.money);
            if(!View_shenMiShop.isSearch || View_shenMiShop.isMulSearch)
            {
               SMSCGMessage.CG_SMS_CHECK_MUL_REFRESH();
            }
            else
            {
               this.update(Model_sms.taoed_goods_arr);
            }
            if(isFirstOpen)
            {
               isFirstOpen = false;
               ComponentUtil.getBitmap("Title_YTDWuPin",this,{
                  "x":249,
                  "y":5
               },Global.SMShop_Imgsdm);
            }
         }
      }
      
      private function ramArr() : void
      {
         var temNum:int = 0;
         var temArr:Array = [];
         var i:int = 0;
         while(i < 6)
         {
            temNum = 1 + Math.random() * this.itemArr.length;
            temArr.push(temNum);
            i++;
         }
      }
      
      public function update(arr:Array) : void
      {
         var i:int = 0;
         this.data = [];
         this.list.reset();
         this.YuanBao_text.text = LangConfig.getWord("25",0) + String(GameUnitManager.hero.money);
         if(arr != null)
         {
            i = 0;
            while(i < arr.length)
            {
               this.data.push({
                  "_vo_id":arr[i][0],
                  "_type":arr[i][1],
                  "price":arr[i][2],
                  "num":arr[i][3],
                  "totalPrice":arr[i][2],
                  "boughtNum":1
               });
               i++;
            }
         }
         if(this.isSetRemain)
         {
            this.list.scrollAutoType = ScrollAutoType.REMAIN;
            this.isSetRemain = false;
         }
         else
         {
            this.list.scrollAutoType = ScrollAutoType.TO_TOP;
         }
         this.list.source = this.data;
         if(Boolean(parent))
         {
            parent.setChildIndex(this,parent.numChildren - 1);
         }
      }
      
      public function update_data_arr_handle(wpId:int, leftNum:int) : void
      {
         var i:int = Model_sms.taoed_goods_arr.length - 1;
         while(i >= 0)
         {
            if(wpId == Model_sms.taoed_goods_arr[i][0])
            {
               Model_sms.taoed_goods_arr[i][3] = leftNum;
               this.isSetRemain = true;
               if(leftNum == 0)
               {
                  this.list.scrollAutoType = ScrollAutoType.REMAIN;
                  Model_sms.taoed_goods_arr.splice(i,1);
                  this.list.removeItem(i);
               }
               return;
            }
            i--;
         }
      }
      
      private function addList() : void
      {
         if(!this.data)
         {
            this.data = [];
         }
         this.list = ComponentUtil.getList(605,373,View_searchItem,this,{
            "x":17,
            "y":77
         },function(data:Object):void
         {
            trace("list data... ",data);
         },-1);
         this.list.x = 31;
         this.list.y = 74;
         this.list.source = this.data;
         this.list.scrollAutoType = ScrollAutoType.TO_TOP;
         addChild(this.list);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - 600) / 2 + 50;
      }
   }
}

