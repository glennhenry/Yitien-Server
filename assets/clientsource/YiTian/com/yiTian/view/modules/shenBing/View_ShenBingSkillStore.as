package com.yiTian.view.modules.shenBing
{
   import Layout.GridGroup;
   import Layout.ILayout;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.view.Panel123;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   
   public class View_ShenBingSkillStore extends Panel123
   {
      
      private var _back:DisplayObject;
      
      private var _items:Array = [];
      
      private var _itemsLay:ILayout = new GridGroup(30,47,0,0,61,0,149,0,2);
      
      private var _tfPage:MyTextField;
      
      private var _tfCurrentPage:int = 0;
      
      private var _canbuys:Array;
      
      private var _maxPage:int;
      
      private var _tfNumStone:MyTextField;
      
      public function View_ShenBingSkillStore()
      {
         super();
         regResource("lang/ch/ShenBing.swf","ShenBingdm");
      }
      
      override protected function initUI2() : void
      {
         var item:Child_ShenBingStoreItem = null;
         this._back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":343,
            "height":393
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this._back.width,38);
         ComponentUtil.getBitmap("Title_JNDH",this,{
            "x":91,
            "y":5
         },Global.ShenBingdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":306,
            "y":6,
            "textColor":16771436,
            "callBack":this.hide
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":23,
            "y":39,
            "width":296,
            "height":345
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Ico_JNSP28",this,{
            "x":39,
            "y":348
         },Global.ShenBingdm);
         this._tfNumStone = ComponentUtil.getTextField("",this,{
            "x":69,
            "y":354,
            "color":15856113
         });
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":144,
            "y":353,
            "width":57,
            "height":22
         },Global.Img_Cdm);
         this._tfPage = ComponentUtil.getTextField("",this,{
            "x":170,
            "y":355,
            "color":14267741
         },TextFieldAutoSize.CENTER);
         this._tfPage.text = "0/0";
         ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":122,
            "y":354,
            "callBack":this.leftClickHd
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_PageRight",this,{
            "x":202,
            "y":354,
            "callBack":this.rightClickHd
         },Global.Img_Cdm);
         var i:int = 0;
         while(i < 10)
         {
            item = new Child_ShenBingStoreItem();
            this._items.push(item);
            this._itemsLay.appendItem(item);
            addChild(item);
            i += 1;
         }
         this._itemsLay.align();
         this._canbuys = Data_lib.sbduihuan.toArray();
         this._maxPage = this._canbuys.length / 10;
         if(this._canbuys.length % 10 == 0)
         {
            this._maxPage -= 1;
         }
      }
      
      public function setPage(index:int) : void
      {
         var item:Child_ShenBingStoreItem = null;
         var id:int = 0;
         var costInfo:String = null;
         if(index < 0)
         {
            return;
         }
         if(index > this._maxPage)
         {
            return;
         }
         var startIndex:int = index * 10;
         var i:int = startIndex;
         while(i < 10)
         {
            item = this._items[i];
            id = 0;
            if(Boolean(this._canbuys[i]))
            {
               costInfo = this._canbuys[i][Enum_ShenBing.SKILL_SOLD_ID + 1];
               id = int(costInfo.split("_")[1]);
            }
            item.update(id,i);
            i += 1;
         }
         this._tfCurrentPage = index;
         this._tfPage.text = (index + 1).toString() + "/" + (this._maxPage + 1).toString();
      }
      
      private function leftClickHd(e:MouseEvent) : void
      {
         this.setPage(this._tfCurrentPage - 1);
      }
      
      private function rightClickHd(e:MouseEvent) : void
      {
         this.setPage(this._tfCurrentPage + 1);
      }
      
      override public function get width() : Number
      {
         return this._back.width;
      }
      
      override public function get height() : Number
      {
         return this._back.height;
      }
      
      public function show(prm:* = null) : void
      {
         this.setPage(0);
         this.visible = true;
      }
      
      public function hide(prm:* = null) : void
      {
         this.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            Global.control.registerCallBack(Enum_MsgType.BAG_UPDATE,this.bagUpdateHd);
            this.bagUpdateHd();
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.BAG_UPDATE,this.bagUpdateHd);
         }
         super.visible = value;
      }
      
      private function bagUpdateHd() : void
      {
         var count:int = CommandManager.get_bag_count(ShenBingUtil.SHENBING_CHIP_ID);
         this._tfNumStone.text = "×" + count;
      }
   }
}

