package com.yiTian.view.modules.tiliStore
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_tiliStore;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.Panel;
   import flash.geom.Rectangle;
   
   public class View_tiliStore extends Panel
   {
      
      public static var res1:int;
      
      public static var res2:int;
      
      public static var res3:int;
      
      private static var vec_item:Vector.<View_TiLiStoreItem>;
      
      private static var isLoad:Boolean = false;
      
      private var idArr:Array = [46391,46390,46389];
      
      public var nameArr:Array = new Array();
      
      private var priceArr:Array = [200,80,40];
      
      private var colorArr:Array = ["#de45c7","#379ae4","#69df36"];
      
      public function View_tiliStore()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":518,
            "height":270
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":470,
            "height":220
         },Global.Img_Cdm);
         move = new Rectangle(0,0,478,38);
         ComponentUtil.getTextField(LangConfig.getWord("60308",6),this,{
            "x":170,
            "y":229,
            "color":16764206,
            "size":12,
            "leading":0
         });
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":484,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            Model_tiliStore.isTiliFull = false;
            this.getNameArr();
            if(!vec_item)
            {
               this.getGrid();
            }
            else
            {
               this.showData(vec_item);
            }
            this.setBtn(0,View_tiliStore.res1 == 0);
            this.setBtn(1,View_tiliStore.res2 == 0);
            this.setBtn(2,View_tiliStore.res3 == 0);
            if(!Global.TiLiStoreImgsdm && !isLoad)
            {
               SingleLoader.add("lang/ch/TiLiStoreImgs.swf",function(info:Object):void
               {
                  Global.TiLiStoreImgsdm = info.applicationDomain;
                  addTl();
               });
            }
            else if(!isLoad)
            {
               this.addTl();
            }
         }
      }
      
      private function addTl() : void
      {
         ComponentUtil.getBitmap("TiLiStore",this,{
            "x":179,
            "y":5
         },Global.TiLiStoreImgsdm);
         isLoad = true;
      }
      
      private function getNameArr() : void
      {
         this.nameArr = [LangConfig.getWord("90",0),LangConfig.getWord("91",0),LangConfig.getWord("92",0)];
      }
      
      private function getGrid() : void
      {
         var temNum:int = 0;
         var temStr:String = null;
         var priceNum:int = 0;
         var temCoStr:String = null;
         var _item:View_TiLiStoreItem = null;
         vec_item = new Vector.<View_TiLiStoreItem>();
         var i:int = 0;
         while(i < 3)
         {
            temNum = int(this.idArr[i]);
            temStr = this.nameArr[i];
            priceNum = int(this.priceArr[i]);
            temCoStr = this.colorArr[i];
            _item = new View_TiLiStoreItem();
            _item.initStoreData(temNum,HtmlUtil.font(temStr,temCoStr),priceNum,i + 1);
            vec_item.push(_item);
            i++;
         }
         this.showData(vec_item);
      }
      
      public function setBtn(_index:int, value:Boolean) : void
      {
         vec_item[_index].setBtn(value);
      }
      
      private function showData(vec_arr:Vector.<View_TiLiStoreItem>) : void
      {
         var _item:View_TiLiStoreItem = null;
         var i:int = 0;
         if(!vec_arr)
         {
            return;
         }
         i = 0;
         while(i < vec_arr.length)
         {
            _item = vec_arr[i];
            _item.x = 30 + i * 154;
            _item.y = 46;
            _item.index = i;
            addChild(_item);
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

