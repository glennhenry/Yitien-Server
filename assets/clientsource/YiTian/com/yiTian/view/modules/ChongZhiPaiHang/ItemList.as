package com.yiTian.view.modules.ChongZhiPaiHang
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_heFu;
   import flash.display.Sprite;
   
   public class ItemList extends Sprite
   {
      
      private var rankID:MyTextField;
      
      private var nameTxt:MyTextField;
      
      private var moneyTxt:MyTextField;
      
      public function ItemList()
      {
         super();
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":0,
            "y":0,
            "width":224,
            "height":24
         },Global.Img_Cdm);
         this.rankID = ComponentUtil.getTextField("00",this,{
            "x":2,
            "y":2,
            "color":15397533,
            "size":12,
            "leading":0
         });
         this.nameTxt = ComponentUtil.getTextField(" 玩家中文名字 S.000 ",this,{
            "x":32,
            "y":2,
            "color":15397533,
            "size":12,
            "leading":0
         });
         this.moneyTxt = ComponentUtil.getTextField("00000000",this,{
            "x":160,
            "y":2,
            "color":15397533,
            "size":12,
            "leading":0
         });
      }
      
      public function setItemList(id:int = -1, name:String = "", address:int = -1, money:int = -1) : void
      {
         if(id == -1)
         {
            this.rankID.text = "";
         }
         else
         {
            this.rankID.text = String(id);
         }
         if(name != "" && address != -1)
         {
            this.nameTxt.text = Model_heFu.repNameByHero(name + ".S" + address);
         }
         else
         {
            this.nameTxt.text = "";
         }
         if(money == -1)
         {
            this.moneyTxt.text = "";
         }
         else
         {
            this.moneyTxt.text = String(money);
         }
      }
   }
}

