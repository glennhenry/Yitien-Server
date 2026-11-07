package com.yiTian.view.modules.tip.tips
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.vo.Vo_Pet;
   import com.yiTian.view.modules.pet.PetPanel;
   import flash.display.Bitmap;
   
   public class View_Pet_Tip extends View_tip
   {
      
      private var nameTF:MyTextField;
      
      private var bm:Bitmap;
      
      private var propertyTF:MyTextField;
      
      public function View_Pet_Tip()
      {
         super();
      }
      
      override public function Init() : void
      {
         addBorder();
         this.nameTF = ComponentUtil.getTextField("",this,{
            "x":5,
            "y":5,
            "color":16043313,
            "realWidth":130,
            "wordWrap":true
         });
         this.bm = new Bitmap();
         this.bm.x = 5;
         this.bm.y = 25;
         addChild(this.bm);
         this.propertyTF = ComponentUtil.getTextField("",this,{
            "x":5,
            "y":65,
            "color":16043313,
            "realWidth":130,
            "wordWrap":true
         });
      }
      
      override public function Show(vo:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         var voPet:Vo_Pet = null;
         voPet = vo as Vo_Pet;
         visible = true;
         if(voPet.petPanelType == PetPanel.XIZI || voPet.petPanelType == PetPanel.LIANHUA)
         {
            this.bm.visible = true;
            this.nameTF.visible = true;
            this.nameTF.y = 5;
            this.propertyTF.y = 65;
            this.nameTF.htmlText = "<b><font color=\'#ffff00\'>" + voPet.str_name + "</font></b>";
            this.propertyTF.htmlText = "<font color=\'#ffff00\'>" + voPet.str_describe + "</font>";
         }
         border.width = this.propertyTF.width + 5;
         border.height = this.propertyTF.y + this.propertyTF.height + 10;
      }
   }
}

