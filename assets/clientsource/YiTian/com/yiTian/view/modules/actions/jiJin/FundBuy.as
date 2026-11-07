package com.yiTian.view.modules.actions.jiJin
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class FundBuy extends Panel123
   {
      
      private var storeI:StoreItem;
      
      private var cItemVec:Vector.<CardItem> = new Vector.<CardItem>();
      
      public function FundBuy()
      {
         super();
         regResource("lang/ch/JiJin_Imgs.swf","JiJin_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         var bm:Bitmap;
         var i:int;
         var sp:Sprite = null;
         var cItem:CardItem = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":637,
            "height":499
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":589,
            "height":450
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":34,
            "y":113,
            "width":569,
            "height":367
         },Global.Img_Cdm);
         move = new Rectangle(0,0,635,38);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":593,
            "y":6,
            "textColor":16184781,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_JiJin",this,{
            "x":239,
            "y":5
         },Global.JiJin_Imgsdm);
         ComponentUtil.getTextField("注：领取完一份基金的所有返利后可购买新的基金。",this,{
            "x":38,
            "y":89,
            "color":327424,
            "size":12,
            "leading":0,
            "bold":true
         });
         sp = new Sprite();
         addChild(sp);
         ComponentUtil.setPropertie(sp,{
            "x":338,
            "y":89
         });
         bm = ComponentUtil.getBitmap("Text_CWWuHun",sp,{
            "x":0,
            "y":0
         },Global.JiJin_Imgsdm);
         sp.buttonMode = true;
         sp.addEventListener(MouseEvent.CLICK,function():void
         {
            ChongZhi.isCheAll = true;
            UIManager.yuanBaoXiang.visible = true;
         });
         TipManager.bind(sp,FundMter.desCripJJ);
         this.storeI = new StoreItem();
         this.storeI.x = 24;
         this.storeI.y = 37;
         addChild(this.storeI);
         i = 0;
         while(i < 3)
         {
            cItem = new CardItem();
            ComponentUtil.setPropertie(cItem,{
               "x":44 + 186 * i,
               "y":123
            });
            addChild(cItem);
            this.cItemVec.push(cItem);
            cItem.update(i + 1);
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
            pop(Global.stage.mouseX / Global.stage.stageWidth,Global.stage.mouseY / Global.stage.stageHeight);
         }
      }
   }
}

