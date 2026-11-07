package com.yiTian.view.modules.MiJingCangZong
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.view.Panel123;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_MiJingCangZong_menu extends Panel123
   {
      
      private static var _instance:View_MiJingCangZong_menu;
      
      private var ZongZiTxt:MyTextField;
      
      private var closeBtn:Button;
      
      private var itemArray:Array;
      
      private var totalPage:int;
      
      private var curPage:int;
      
      private var prevBtn:Button;
      
      private var nextBtn:Button;
      
      private var pageTxt:MyTextField;
      
      public function View_MiJingCangZong_menu()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/ChunJie_Imgs.swf","ChunJie_Imgsdm");
         regResource("lang/ch/MiJingCangZong_Imgs.swf","MiJingCangZong_Imgs");
      }
      
      public static function get instance() : View_MiJingCangZong_menu
      {
         if(!_instance)
         {
            _instance = new View_MiJingCangZong_menu();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var i:int = 0;
         var item:Item = null;
         move = new Rectangle(0,0,710,30);
         ComponentUtil.getScaleBitmap("Store_Back1",[229,44,2,3],this,{
            "x":0,
            "y":3,
            "width":710,
            "height":578
         },Global.ChunJie_Imgsdm);
         ComponentUtil.getBitmap("Store_Title",this,{
            "x":229,
            "y":0
         },Global.MiJingCangZong_Imgs);
         ComponentUtil.getScaleBitmap("Store_Back4",[2,2,4,4],this,{
            "x":28,
            "y":47,
            "width":654,
            "height":524
         },Global.ChunJie_Imgsdm);
         ComponentUtil.getBitmap("Store_Img",this,{
            "x":38,
            "y":57
         },Global.MiJingCangZong_Imgs);
         ComponentUtil.getTextField("粽子：",this,{
            "x":48,
            "y":542,
            "color":327424,
            "size":12,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Store_Back3",[3,3,4,4],this,{
            "x":327,
            "y":539,
            "width":57,
            "height":23
         },Global.ChunJie_Imgsdm);
         this.totalPage = Math.max(1,Math.ceil(Data_lib.zzsc.getLength() / 9));
         this.curPage = 0;
         this.itemArray = [];
         i = 0;
         while(i < 9)
         {
            item = new Item();
            item.x = 38 + i % 3 * 213;
            item.y = 191 + int(i / 3) * 116;
            addChild(item);
            this.itemArray.push(item);
            i++;
         }
         this.setCurPageGrid();
         this.ZongZiTxt = ComponentUtil.getTextField("000000",this,{
            "x":89,
            "y":542,
            "color":16383744,
            "size":12,
            "leading":0
         });
         this.prevBtn = ComponentUtil.getButton("","Button_PageL",this,{
            "x":299,
            "y":539,
            "textColor":16184781
         },Global.ChunJie_Imgsdm);
         this.prevBtn.callBack = this.changePage;
         this.prevBtn.enabled = false;
         this.nextBtn = ComponentUtil.getButton("","Button_PageR",this,{
            "x":388,
            "y":539,
            "textColor":16184781
         },Global.ChunJie_Imgsdm);
         this.nextBtn.callBack = this.changePage;
         if(this.totalPage < 2)
         {
            this.nextBtn.enabled = false;
         }
         this.pageTxt = ComponentUtil.getTextField("1/1",this,{
            "x":355,
            "y":541,
            "color":16777215,
            "size":12,
            "leading":0
         },"center");
         this.closeBtn = ComponentUtil.getButton("","Button_SClose",this,{
            "x":658,
            "y":14,
            "textColor":16184781
         },Global.ChunJie_Imgsdm);
         this.closeBtn.callBack = function():void
         {
            visible = false;
         };
      }
      
      private function setCurPageGrid() : void
      {
         var i:* = undefined;
         for(i in this.itemArray)
         {
            if(i + 9 * this.curPage < Data_lib.zzsc.getLength())
            {
               this.itemArray[i].setItem(Data_lib.zzsc[i + 9 * this.curPage + 1][0],Data_lib.zzsc[i + 9 * this.curPage + 1][1]);
               this.itemArray[i].visible = true;
            }
            else
            {
               this.itemArray[i].visible = false;
            }
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.UpdateZongZiCount();
         }
      }
      
      public function UpdateZongZiCount() : void
      {
         this.ZongZiTxt.text = CommandManager.get_bag_count(44701).toString();
      }
      
      private function changePage(e:MouseEvent) : void
      {
         if(e.currentTarget == this.prevBtn)
         {
            this.nextBtn.enabled = true;
            --this.curPage;
            if(this.curPage == 0)
            {
               this.prevBtn.enabled = false;
            }
         }
         else
         {
            this.prevBtn.enabled = true;
            ++this.curPage;
            if(this.curPage == this.totalPage - 1)
            {
               this.nextBtn.enabled = false;
            }
         }
         this.pageTxt.text = this.curPage + 1 + "/" + this.totalPage;
      }
   }
}

