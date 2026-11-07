package com.yiTian.view.modules.keJu
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.utils.Util;
   import com.yiTian.data.model.Model_heFu;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class RankItem extends Sprite
   {
      
      private static const NUMCOLOR:Array = [6684876,26367,39168];
      
      private var numTF:MyTextField;
      
      private var nameTF:MyTextField;
      
      private var scoresTF:MyTextField;
      
      private var timeTF:MyTextField;
      
      private var mouseBack:DisplayObject;
      
      public function RankItem()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.mouseBack = ComponentUtil.getDisplayObject("Item_Select",this,{
            "width":240,
            "height":19,
            "y":3
         });
         this.mouseBack.visible = false;
         this.mouseBack.alpha = 0;
         this.mouseBack.addEventListener(MouseEvent.MOUSE_OVER,this.onOverHandler);
         this.mouseBack.addEventListener(MouseEvent.MOUSE_OUT,this.onOutHandler);
         this.numTF = ComponentUtil.getTextField("",this,{
            "x":5,
            "y":3,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.nameTF = ComponentUtil.getTextField("",this,{
            "x":98 - 30,
            "y":3,
            "color":11904647,
            "size":12,
            "leading":0,
            "realWidth":135
         });
         this.nameTF.align = "center";
         this.scoresTF = ComponentUtil.getTextField("",this,{
            "x":45,
            "y":3,
            "color":11904647,
            "size":12,
            "leading":0,
            "realWidth":25
         });
         this.scoresTF.align = "center";
         this.timeTF = ComponentUtil.getTextField("",this,{
            "x":200,
            "y":3,
            "color":11904647,
            "size":12,
            "leading":0
         });
      }
      
      public function updata(vo:RankVO, num:int) : void
      {
         var color:int = 0;
         if(num <= 3)
         {
            this.numTF.filters = [];
            this.nameTF.filters = [];
            this.scoresTF.filters = [];
            this.timeTF.filters = [];
            color = int(NUMCOLOR[num - 1]);
         }
         else
         {
            this.numTF.filters = Util.glow000000;
            this.nameTF.filters = Util.glow000000;
            this.scoresTF.filters = Util.glow000000;
            this.timeTF.filters = Util.glow000000;
            color = 16777215;
         }
         this.numTF.color = this.nameTF.color = this.scoresTF.color = this.timeTF.color = color;
         this.numTF.text = num + "";
         vo.name = Model_heFu.repNameByHero(vo.name);
         this.nameTF.text = vo.name;
         this.scoresTF.text = vo.scores + "";
         this.timeTF.text = DateUtil.getMSBySecond3(vo.time);
         this.mouseBack.visible = true;
      }
      
      public function dispose() : void
      {
         this.numTF.text = this.nameTF.text = this.scoresTF.text = this.timeTF.text = "";
         this.mouseBack.visible = false;
      }
      
      private function onOutHandler(e:MouseEvent) : void
      {
         this.mouseBack.alpha = 0;
      }
      
      private function onOverHandler(e:MouseEvent) : void
      {
         this.mouseBack.alpha = 1;
      }
   }
}

