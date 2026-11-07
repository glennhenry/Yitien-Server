package com.yiTian.view.modules.fruitShop
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.valuable.Enum_color;
   import com.yiTian.data.vo.Vo_fruitShop;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.FruitShopHandler;
   import com.yiTian.net.message.cg.FruitShopCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flashx.textLayout.formats.TextAlign;
   
   public class Child_FruitShop extends Sprite
   {
      
      private var backBitmap:Bitmap;
      
      private var grid:View_Grid;
      
      private var nameTxt:MyTextField;
      
      private var timesTxt:MyTextField;
      
      private var xgTxt:MyTextField;
      
      private var liTxt:MyTextField;
      
      private var pgTxt:MyTextField;
      
      private var buyBtn:Button;
      
      public var vo:Vo_fruitShop;
      
      private var times:int;
      
      private var matReqArr:Array = [];
      
      public function Child_FruitShop($vo:Vo_fruitShop = null)
      {
         super();
         this.vo = $vo;
         this.backBitmap = ComponentUtil.getBitmap("BG_SGP",this,{
            "x":0,
            "y":0
         },Global.fruitShop_Imgsdm);
         this.grid = new View_Grid(true);
         this.grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
         this.grid.set_bmp_over(true,null);
         this.grid.set_tf_count();
         this.grid.x = 59;
         this.grid.y = 30;
         addChild(this.grid);
         this.nameTxt = ComponentUtil.getTextField("物品名字六个",this,{
            "x":55,
            "y":4,
            "color":327424,
            "size":12,
            "leading":0,
            "align":TextAlign.CENTER
         });
         this.timesTxt = ComponentUtil.getTextField("剩余\n0次",this,{
            "x":154,
            "y":4,
            "color":16776960,
            "size":12,
            "leading":0,
            "realWidth":32,
            "realHeight":32,
            "size":12
         });
         var txt1:MyTextField = ComponentUtil.getTextField(LangConfig.getWord("20053",11),this,{
            "x":14,
            "y":106,
            "color":3394815,
            "size":12,
            "leading":0
         });
         var bm1:Bitmap = ComponentUtil.getBitmap("Ico_XG",this,{
            "x":47,
            "y":105
         },Global.fruitShop_Imgsdm);
         this.xgTxt = ComponentUtil.getTextField("x 0 ",this,{
            "x":65,
            "y":107,
            "color":16776960,
            "size":12,
            "leading":0
         });
         var bm2:Bitmap = ComponentUtil.getBitmap("Ico_Li",this,{
            "x":89,
            "y":105
         },Global.fruitShop_Imgsdm);
         this.liTxt = ComponentUtil.getTextField("x 0 ",this,{
            "x":107,
            "y":107,
            "color":16776960,
            "size":12,
            "leading":0
         });
         var bm3:Bitmap = ComponentUtil.getBitmap("Ico_PG",this,{
            "x":131,
            "y":105
         },Global.fruitShop_Imgsdm);
         this.pgTxt = ComponentUtil.getTextField("x 0 ",this,{
            "x":149,
            "y":107,
            "color":16776960,
            "size":12,
            "leading":0
         });
         this.buyBtn = ComponentUtil.getButton(LangConfig.getWord("20054",11),"BT_DH",this,{
            "x":61,
            "y":134,
            "textColor":16771436,
            "callBack":this.onBuyHandler
         },Global.fruitShop_Imgsdm);
         this.buyBtn.labelTF.y -= 20;
      }
      
      private function onBuyHandler(e:MouseEvent) : void
      {
         if(!this.vo)
         {
            return;
         }
         if(this.vo.buyTimes <= 0)
         {
            UIManager.centerBroadcast.addMsg("活动期间可购买数量已使用完");
            return;
         }
         var num:int = CommandManager.get_bag_canUse() - CommandManager.get_bag_used();
         if(CommandManager.get_bag_count(this.vo.itemVo.id) <= 0)
         {
            if(num < 1)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("106",0));
               return;
            }
         }
         FruitShopCGMessage.CG_FRUIT_SHOP_BUY(this.vo.index);
      }
      
      public function updateVo() : void
      {
         var str:String = null;
         var obj:Object = null;
         var matArr:Array = null;
         var num1:String = null;
         var num2:String = null;
         var num3:String = null;
         if(!this.vo)
         {
            visible = false;
            return;
         }
         visible = true;
         if(this.vo.itemVo.color == Enum_color.WHITE)
         {
            str = ColorConstant.getColorStr(ColorConstant.WHITE);
         }
         else if(this.vo.itemVo.color == Enum_color.GREEN)
         {
            str = ColorConstant.getColorStr(ColorConstant.GREEN);
         }
         else if(this.vo.itemVo.color == Enum_color.BLUE)
         {
            str = ColorConstant.getColorStr(ColorConstant.BLUE);
         }
         else if(this.vo.itemVo.color == Enum_color.PURPLE)
         {
            str = ColorConstant.getColorStr(ColorConstant.PURPLE);
         }
         else if(this.vo.itemVo.color == Enum_color.ORANGE)
         {
            str = ColorConstant.getColorStr(ColorConstant.ORANGE);
         }
         str = HtmlUtil.font(this.vo.name,str);
         this.nameTxt.htmlText = str;
         this.times = this.vo.buyTimes;
         this.timesTxt.text = LangConfig.getWord("20052",11,"\n" + this.times);
         var a:Array = FruitShopHandler.list;
         for each(obj in FruitShopHandler.list)
         {
            if(obj.index == this.vo.index)
            {
               this.vo.buyTimes = obj.buyTimes;
               this.updateTimes(obj.buyTimes);
            }
         }
         matArr = this.vo.mats.split(",");
         num1 = matArr[0].split("_")[1];
         num2 = matArr[1].split("_")[1];
         num3 = matArr[2].split("_")[1];
         this.matReqArr[0] = num1;
         this.matReqArr[1] = num2;
         this.matReqArr[2] = num3;
         this.xgTxt.text = "x" + num1;
         this.liTxt.text = "x" + num2;
         this.pgTxt.text = "x" + num3;
         this.grid.vo = this.vo.itemVo;
         this.grid.count = this.vo.itemVo.count;
      }
      
      private function updateTimes(bought:int) : void
      {
         var leftTime:int = this.times - bought;
         this.timesTxt.text = LangConfig.getWord("20052",11,"\n" + leftTime);
      }
   }
}

