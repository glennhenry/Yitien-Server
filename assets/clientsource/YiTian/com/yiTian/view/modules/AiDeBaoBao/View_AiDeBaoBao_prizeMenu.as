package com.yiTian.view.modules.AiDeBaoBao
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import flash.geom.Rectangle;
   
   public class View_AiDeBaoBao_prizeMenu extends Panel
   {
      
      private static var _instance:View_AiDeBaoBao_prizeMenu;
      
      public function View_AiDeBaoBao_prizeMenu()
      {
         super();
         super.init();
      }
      
      public static function get instance() : View_AiDeBaoBao_prizeMenu
      {
         if(!_instance)
         {
            _instance = new View_AiDeBaoBao_prizeMenu();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         var i:int = 0;
         var txt:MyTextField = null;
         var prizeArr:Array = null;
         var j:int = 0;
         var txtArr:Array = null;
         var prizeStr:String = null;
         var grid:View_Grid = null;
         var vo:Vo_item = null;
         move = new Rectangle(45,40,300,30);
         ComponentUtil.getBitmap("Back_Gift",this,{
            "x":0,
            "y":0
         },Global.ADBB_Imgsdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":355,
            "y":47,
            "textColor":16184781
         },Global.ADBB_Imgsdm);
         i = 0;
         while(i < Data_lib.aidebaobao.getLength())
         {
            txt = ComponentUtil.getTextField("",this,{
               "x":140,
               "y":116 + i * 43,
               "color":16777215,
               "size":16,
               "leading":0
            },"center");
            if(Data_lib.aidebaobao[i + 1][0] == 0)
            {
               txt.text = "爱心奖励";
            }
            else
            {
               txtArr = String(Data_lib.aidebaobao[i + 1][0]).split("_");
               if(txtArr.length == 1)
               {
                  txt.text = "第" + txtArr[0] + "名";
               }
               else
               {
                  txt.text = "第" + txtArr[0] + "-" + txtArr[1] + "名";
               }
            }
            prizeArr = String(Data_lib.aidebaobao[i + 1][1]).split(",");
            j = 0;
            while(j < 3)
            {
               prizeStr = prizeArr[j];
               if(!prizeStr)
               {
                  break;
               }
               grid = new View_Grid();
               grid.set_bmp_bg();
               grid.set_bmp_over();
               grid.set_tf_count();
               grid.isAutoLoad = true;
               vo = new Vo_item();
               vo.id = prizeStr.split("_")[1];
               vo.count = prizeStr.split("_")[2];
               vo.Init_lib();
               grid.vo = vo;
               grid.x = 245 + j * 45;
               grid.y = 110 + i * 43;
               addChild(grid);
               j++;
            }
            if(i > 0)
            {
               ComponentUtil.getBitmap("JLLine",this,{
                  "x":78,
                  "y":105 + 43 * i
               },Global.ADBB_Imgsdm);
            }
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

