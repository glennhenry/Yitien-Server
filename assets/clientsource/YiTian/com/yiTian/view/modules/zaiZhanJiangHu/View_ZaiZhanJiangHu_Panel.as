package com.yiTian.view.modules.zaiZhanJiangHu
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.net.message.cg.ZaiZhanJiangHuCGMessage;
   import com.yiTian.view.Panel123;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class View_ZaiZhanJiangHu_Panel extends Panel123
   {
      
      private static var _instance:View_ZaiZhanJiangHu_Panel;
      
      public static var data_arr:Array = [];
      
      public static var _awardNum:int = 0;
      
      public static var getNum:int = 0;
      
      public static var unReach:int = 0;
      
      private var _itemNumArr:Array = [4,5,6];
      
      private var closeBtn:Button;
      
      private var con:Sprite;
      
      private var itemVec:Vector.<JH_PanelItem> = new Vector.<JH_PanelItem>(3);
      
      private var _isUpdated:Boolean = false;
      
      public function View_ZaiZhanJiangHu_Panel()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/ZaiZhanJiangHu.swf","ZZJH_Imgsdm");
      }
      
      public static function get instance() : View_ZaiZhanJiangHu_Panel
      {
         if(!_instance)
         {
            _instance = new View_ZaiZhanJiangHu_Panel();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var item:JH_PanelItem = null;
         move = new Rectangle(0,0,682,38);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":657,
            "height":464
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":607,
            "height":414
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":179,
            "width":582,
            "height":263
         },Global.ZZJH_Imgsdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":52,
            "width":582,
            "height":123
         },Global.ZZJH_Imgsdm);
         ComponentUtil.getBitmap("Back_CRZH",this,{
            "x":44,
            "y":59
         },Global.ZZJH_Imgsdm);
         ComponentUtil.getBitmap("Text_CRZH",this,{
            "x":246,
            "y":85
         },Global.ZZJH_Imgsdm);
         ComponentUtil.getBitmap("Text_ZJZ",this,{
            "x":428,
            "y":121
         },Global.ZZJH_Imgsdm);
         ComponentUtil.getScaleBitmap("Back_LBHB",[34,34,1,1],this,{
            "x":37,
            "y":179,
            "width":582,
            "height":262
         },Global.ZZJH_Imgsdm);
         ComponentUtil.getScaleBitmap("Back_LBD",[4,4,1,1],this,{
            "x":47,
            "y":186,
            "width":562,
            "height":80
         },Global.ZZJH_Imgsdm);
         ComponentUtil.getScaleBitmap("Back_LBD",[4,4,1,1],this,{
            "x":47,
            "y":270,
            "width":562,
            "height":80
         },Global.ZZJH_Imgsdm);
         ComponentUtil.getScaleBitmap("Back_LBD",[4,4,1,1],this,{
            "x":47,
            "y":354,
            "width":562,
            "height":80
         },Global.ZZJH_Imgsdm);
         ComponentUtil.getBitmap("Text_Rgsday_02",this,{
            "x":173,
            "y":279
         },Global.ZZJH_Imgsdm);
         ComponentUtil.getBitmap("Text_Rgsday_03",this,{
            "x":173,
            "y":363
         },Global.ZZJH_Imgsdm);
         ComponentUtil.getBitmap("Text_Rgsday_01",this,{
            "x":173,
            "y":195
         },Global.ZZJH_Imgsdm);
         ComponentUtil.getBitmap("Title_ZZJH",this,{
            "x":249,
            "y":5
         },Global.ZZJH_Imgsdm);
         this.visible = false;
         this.con = new Sprite();
         addChild(this.con);
         var len:int = int(this.itemVec.length);
         var i:int = 0;
         while(i < len)
         {
            item = new JH_PanelItem(this._itemNumArr[i]);
            ComponentUtil.setPropertie(item,{
               "x":78,
               "y":192 + i * 84
            });
            this.con.addChild(item);
            this.itemVec[i] = item;
            i++;
         }
         this.closeBtn = ComponentUtil.getButton("","Button_Close",this,{
            "x":622,
            "y":5,
            "textColor":16184781
         },Global.Img_Cdm);
         this.closeBtn.callBack = this.closeMenu;
      }
      
      public function getPanelItem(index:int) : void
      {
         var tempItem:JH_PanelItem = this.itemVec[index];
         tempItem.getAwards();
         ++getNum;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            if(this._isUpdated)
            {
               super.visible = value;
               return;
            }
            ZaiZhanJiangHuCGMessage.CG_ZZJH_IconClick();
         }
         else
         {
            super.visible = value;
            if(_awardNum >= 1)
            {
               View_ZaiZhanJiangHu_icon.instance.effectBegin();
            }
            else
            {
               View_ZaiZhanJiangHu_icon.instance.effectEnd();
            }
            this._isUpdated = false;
         }
      }
      
      public function update() : void
      {
         var status:int = 0;
         var leftDay:int = 0;
         var item:JH_PanelItem = null;
         if(!data_arr.length)
         {
            return;
         }
         _awardNum = 0;
         var len:int = int(data_arr.length);
         var i:int = 0;
         while(i < len)
         {
            status = int(data_arr[i][0]);
            leftDay = int(data_arr[i][1]);
            item = this.itemVec[i];
            item.update(i + 1,status,leftDay);
            if(status == 1)
            {
               ++_awardNum;
            }
            i++;
         }
         this._isUpdated = true;
         if(this._isUpdated)
         {
            this.visible = true;
         }
         if(_awardNum >= 1)
         {
            View_ZaiZhanJiangHu_icon.instance.effectBegin();
         }
         else
         {
            View_ZaiZhanJiangHu_icon.instance.effectEnd();
         }
      }
      
      private function closeMenu(e:*) : void
      {
         this.visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

