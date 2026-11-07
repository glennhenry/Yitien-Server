package com.yiTian.view.modules.treeDownCL
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.Singleton;
   import flash.geom.Point;
   
   public class Child_infomAnswer extends SmallPan
   {
      
      private var itemF:ConF;
      
      private var itemS:ConS;
      
      public function Child_infomAnswer()
      {
         super();
         regSource("DaShu_Imgsdm","DaShu_Imgs");
      }
      
      public static function get instance() : Child_infomAnswer
      {
         return Singleton.getInstance(Child_infomAnswer);
      }
      
      override protected function initSource() : void
      {
         ComponentUtil.getBitmap("Back_Num",this,{
            "x":0,
            "y":0
         },Global.DaShu_Imgsdm);
         ComponentUtil.getBitmap("Title_ChengLiang",this,{
            "x":102,
            "y":-40
         },Global.DaShu_Imgsdm);
         this.itemF = new ConF();
         addChild(this.itemF);
         ComponentUtil.setPropertie(this.itemF,{"y":6});
         this.itemS = new ConS();
         addChild(this.itemS);
      }
      
      public function update(corr:int, inCorr:int, cur:int, tot:int) : void
      {
         if(!visible)
         {
            visible = true;
         }
         super.init({
            "correct":corr,
            "inCorrect":inCorr,
            "current":cur,
            "total":tot
         },function(obj:Object):void
         {
            itemF.update(obj);
            itemS.visible = false;
         });
      }
      
      public function moveTf(cnt:int) : void
      {
         if(!visible)
         {
            visible = true;
         }
         super.init(cnt,function(cnt:int):void
         {
            itemS.update(cnt);
            itemF.visible = false;
         });
      }
      
      public function get getSomeTfPos() : Point
      {
         return this.itemS.tfPos;
      }
      
      public function hide() : void
      {
         visible = false;
         if(Boolean(this.itemS))
         {
            this.itemS.visible = false;
         }
         if(Boolean(this.itemF))
         {
            this.itemF.visible = false;
         }
      }
      
      override protected function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 413) / 2;
         y = Global.stage.stageHeight - 170;
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.net.message.cg.TreeDownCLCGMessage;
import com.yiTian.view.modules.treeDownCL.CountTfManager;
import com.yiTian.view.modules.treeDownCL.Model_treeCL;
import com.yiTian.view.modules.treeDownCL.lUtils.MoveObj;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.Point;
import flashx.textLayout.formats.TextAlign;

class ConF extends Sprite
{
   
   private var correctTf:MyTextField;
   
   private var inCorrectTf:MyTextField;
   
   private var currentTf:MyTextField;
   
   private var totalTf:MyTextField;
   
   public function ConF()
   {
      super();
      ComponentUtil.getBitmap("Line_Shu",this,{
         "x":115,
         "y":0
      },Global.DaShu_Imgsdm);
      ComponentUtil.getBitmap("Line_Shu",this,{
         "x":225,
         "y":0
      },Global.DaShu_Imgsdm);
      ComponentUtil.getTextField("正确：",this,{
         "x":42,
         "y":13,
         "color":11523767,
         "size":12,
         "leading":0
      });
      ComponentUtil.getTextField("错误：",this,{
         "x":151,
         "y":13,
         "color":11523767,
         "size":12,
         "leading":0
      });
      ComponentUtil.getTextField("当前：",this,{
         "x":252,
         "y":13,
         "color":11523767,
         "size":12,
         "leading":0
      });
      this.correctTf = ComponentUtil.getTextField("",this,{
         "x":83,
         "y":13,
         "color":2929447,
         "size":12,
         "leading":0
      });
      this.inCorrectTf = ComponentUtil.getTextField("",this,{
         "x":192,
         "y":13,
         "color":12521472,
         "size":12,
         "leading":0
      });
      this.currentTf = ComponentUtil.getTextField("",this,{
         "x":290,
         "y":13,
         "color":2329631,
         "size":12,
         "leading":0
      });
      this.totalTf = ComponentUtil.getTextField("",this,{
         "x":312,
         "y":13,
         "color":16764206,
         "size":12,
         "leading":0
      });
   }
   
   public function update(obj:Object) : void
   {
      if(!visible)
      {
         visible = true;
      }
      this.correctTf.text = obj.correct.toString();
      this.inCorrectTf.text = obj.inCorrect.toString();
      this.currentTf.text = obj.current.toString();
      this.totalTf.text = "（共" + obj.total.toString() + "题）";
   }
}

class ConS extends Sprite
{
   
   private var thirdTfCount:MyTextField;
   
   private var scaleBm:Bitmap;
   
   public function ConS()
   {
      super();
      this.thirdTfCount = ComponentUtil.getTextField("",this,{
         "x":242,
         "y":4,
         "color":16383744,
         "bold":true,
         "size":16,
         "align":TextAlign.CENTER,
         "realWidth":30
      });
      ComponentUtil.getTextField("答题倒计时：",this,{
         "x":147,
         "y":4,
         "color":16383744,
         "bold":true,
         "size":16
      });
      this.scaleBm = ComponentUtil.getBitmap("Text_ChengLiang",this,{
         "x":98,
         "y":27
      },Global.DaShu_Imgsdm);
   }
   
   public function update(count:int) : void
   {
      if(!visible)
      {
         this.visible = true;
      }
      MoveObj.addMoveTf(this.scaleBm,370,50);
      this.thirdTfCount.text = count.toString();
      CountTfManager.add(this.thirdTfCount,count,false,function(_cnt:int):void
      {
         Model_treeCL.anSwerSign = true;
         if(_cnt <= 0)
         {
            CountTfManager.remove(thirdTfCount);
            Model_treeCL.anSwerSign = false;
            TreeDownCLCGMessage.CG_SENDANSWER_TREECL(Model_treeCL.answerKey,Model_treeCL.answerArr[Model_treeCL.answerId]);
         }
      });
   }
   
   public function get tfPos() : Point
   {
      return localToGlobal(new Point(this.thirdTfCount.x,this.thirdTfCount.y));
   }
   
   override public function set visible(value:Boolean) : void
   {
      super.visible = value;
      if(!value)
      {
         MoveObj.stop(this.scaleBm);
         CountTfManager.remove(this.thirdTfCount);
      }
   }
}
