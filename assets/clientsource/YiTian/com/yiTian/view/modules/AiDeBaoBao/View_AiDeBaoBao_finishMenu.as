package com.yiTian.view.modules.AiDeBaoBao
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.net.message.cg.AiDeBaoBaoCGMessage;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   
   public class View_AiDeBaoBao_finishMenu extends Panel
   {
      
      private static var _instance:View_AiDeBaoBao_finishMenu;
      
      private var costTimeTxt:MyTextField;
      
      private var rankTxt:MyTextField;
      
      private var returnBtn:Button;
      
      private var bgBMDT:Array;
      
      private var bg:Bitmap;
      
      private var gridArr:Array;
      
      public function View_AiDeBaoBao_finishMenu()
      {
         super();
         super.init();
      }
      
      public static function get instance() : View_AiDeBaoBao_finishMenu
      {
         if(!_instance)
         {
            _instance = new View_AiDeBaoBao_finishMenu();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         var i:int;
         var grid:View_Grid = null;
         this.bgBMDT = [];
         this.bgBMDT.push(ComponentUtil.getBitmapData("Back_BBJL",Global.ADBB_Imgsdm));
         this.bgBMDT.push(ComponentUtil.getBitmapData("Back_AXJL",Global.ADBB_Imgsdm));
         this.bgBMDT.push(ComponentUtil.getBitmapData("Back_WCBS",Global.ADBB_Imgsdm));
         this.bg = ComponentUtil.getBitmap("Back_BBJL",this,{
            "x":0,
            "y":0
         },Global.ADBB_Imgsdm);
         this.costTimeTxt = ComponentUtil.getTextField("",this,{
            "x":385,
            "y":99,
            "color":16776960,
            "size":18,
            "leading":0
         },"center");
         this.rankTxt = ComponentUtil.getTextField("",this,{
            "x":252,
            "y":99,
            "color":16776960,
            "size":18,
            "leading":0
         });
         this.returnBtn = ComponentUtil.getButton("","Button_LJFH",this,{
            "x":142,
            "y":280,
            "textColor":16771436
         },Global.ADBB_Imgsdm);
         CloseButton = ComponentUtil.getButton("","Button_ZBFH",this,{
            "x":252,
            "y":280,
            "textColor":16771436
         },Global.ADBB_Imgsdm);
         this.returnBtn.callBack = function():void
         {
            AiDeBaoBaoCGMessage.CG_AiDeBaoBao_RETURN_TO_BEGIN();
         };
         this.gridArr = [];
         i = 0;
         while(i < 3)
         {
            grid = new View_Grid();
            grid.set_bmp_bg();
            grid.set_bmp_over();
            grid.set_tf_count();
            addChild(grid);
            grid.x = 177 + i * 55;
            grid.y = 165;
            this.gridArr.push(grid);
            grid.visible = false;
            i++;
         }
      }
      
      public function setCostTime(costTime:int, rank:int) : void
      {
         var vo:Vo_item = null;
         var i:int = 0;
         var prizeArr:Array = null;
         var j:int = 0;
         var vo1:Vo_item = null;
         var vo2:Vo_item = null;
         this.costTimeTxt.text = String(int(costTime / 3600)) + ":" + String(int(costTime % 3600 / 60) + 100).substr(1) + ":" + String(costTime % 3600 % 60 + 100).substr(1);
         this.rankTxt.text = rank.toString();
         if(rank > 10)
         {
            this.bg.bitmapData = this.bgBMDT[0];
            this.costTimeTxt.visible = true;
            this.rankTxt.visible = true;
            this.gridArr[0].visible = false;
            this.gridArr[1].visible = true;
            this.gridArr[2].visible = false;
            vo = new Vo_item();
            vo.id = 46382;
            vo.Init_lib();
            this.gridArr[1].vo = vo;
            this.gridArr[1].count = 0;
         }
         else
         {
            if(rank > 0)
            {
               this.bg.bitmapData = this.bgBMDT[0];
               this.costTimeTxt.visible = true;
               this.rankTxt.visible = true;
               i = 1;
               while(i < Data_lib.aidebaobao.getLength() - 1 && rank >= Data_lib.aidebaobao[i + 1][2])
               {
                  i++;
               }
            }
            else if(rank == 0)
            {
               i = int(Data_lib.aidebaobao.getLength());
               this.bg.bitmapData = this.bgBMDT[1];
               this.costTimeTxt.visible = false;
               this.rankTxt.visible = false;
            }
            else if(rank == -1)
            {
               i = int(Data_lib.aidebaobao.getLength());
               this.bg.bitmapData = this.bgBMDT[2];
               this.costTimeTxt.visible = false;
               this.rankTxt.visible = false;
            }
            prizeArr = Data_lib.aidebaobao[i][1].split(",");
            j = 0;
            while(j < 3)
            {
               if(j == 0)
               {
                  this.gridArr[j].visible = true;
                  vo1 = new Vo_item();
                  vo1.id = 46382;
                  vo1.Init_lib();
                  this.gridArr[j].vo = vo1;
                  this.gridArr[j].count = 0;
               }
               else if(Boolean(prizeArr[j - 1]))
               {
                  this.gridArr[j].visible = true;
                  vo2 = new Vo_item();
                  vo2.id = prizeArr[j - 1].split("_")[1];
                  vo2.Init_lib();
                  this.gridArr[j].vo = vo2;
                  this.gridArr[j].count = prizeArr[j - 1].split("_")[2];
               }
               else
               {
                  this.gridArr[j].visible = false;
               }
               j++;
            }
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

