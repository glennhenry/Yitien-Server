package com.yiTian.view.modules.keJu
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.data.model.Model_heFu;
   import flash.display.Sprite;
   
   public class PoemsRankItem extends Sprite
   {
      
      private var numTF:MyTextField;
      
      private var nameTF:MyTextField;
      
      private var poemsTF:MyTextField;
      
      private var timeTF:MyTextField;
      
      public function PoemsRankItem()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.numTF = ComponentUtil.getTextField("",this,{
            "x":5,
            "y":5,
            "color":39168,
            "size":12,
            "leading":0
         });
         this.nameTF = ComponentUtil.getTextField("",this,{
            "x":36,
            "y":5,
            "color":39168,
            "size":12,
            "leading":0,
            "realWidth":77
         });
         this.nameTF.align = "center";
         this.poemsTF = ComponentUtil.getTextField("",this,{
            "x":125,
            "y":5,
            "color":39168,
            "size":12,
            "leading":0,
            "realWidth":20
         });
         this.poemsTF.align = "center";
         this.timeTF = ComponentUtil.getTextField("",this,{
            "x":162,
            "y":5,
            "color":39168,
            "size":12,
            "leading":0
         });
      }
      
      public function updata(vo:RankVO, num:int) : void
      {
         this.numTF.text = num + "";
         vo.name = Model_heFu.repNameByHero(vo.name);
         this.nameTF.text = vo.name + "";
         this.poemsTF.text = vo.scores + "";
         this.timeTF.text = DateUtil.transDate(vo.time);
      }
      
      public function dispose() : void
      {
         this.numTF.text = this.nameTF.text = this.timeTF.text = this.poemsTF.text = "";
      }
   }
}

