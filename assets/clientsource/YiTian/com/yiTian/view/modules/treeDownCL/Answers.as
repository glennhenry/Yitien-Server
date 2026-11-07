package com.yiTian.view.modules.treeDownCL
{
   import com.yiTian.Global;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Singleton;
   
   public class Answers
   {
      
      public static var Left:int = 0;
      
      public static var Right:int = 1;
      
      public static var posArr:Array = [[{
         "x":1,
         "y":0
      },{
         "x":58,
         "y":16
      },{
         "x":160,
         "y":10
      }],[{
         "x":0,
         "y":0
      },{
         "x":52,
         "y":16
      },{
         "x":12,
         "y":11
      }]];
      
      private static var answerLen:int = 2;
      
      private static var _pointArr:Array = [];
      
      private var answerVec:Vector.<AnItem> = new Vector.<AnItem>(answerLen);
      
      public function Answers()
      {
         super();
         this.init();
      }
      
      public static function get instance() : Answers
      {
         return Singleton.getInstance(Answers);
      }
      
      private static function get pointArr() : Array
      {
         if(!_pointArr.length)
         {
            _pointArr = [{
               "x":(Global.stage.stageWidth - 197) / 2 - 297,
               "y":140
            },{
               "x":Global.stage.stageWidth / 2 + 194,
               "y":140
            }];
         }
         return _pointArr;
      }
      
      public function init() : void
      {
         var answerI:AnItem = null;
         var posObj:Object = null;
         var i:int = 0;
         while(i < this.answerVec.length)
         {
            answerI = new AnItem();
            posObj = pointArr[i];
            answerI.initB(posArr[i],i,posObj);
            this.answerVec[i] = answerI;
            i++;
         }
      }
      
      public function showAnswer(ansArr:Array) : void
      {
         var item:AnItem = null;
         var answer:String = null;
         var i:int = 0;
         while(i < this.answerVec.length)
         {
            item = this.answerVec[i];
            answer = ansArr[i];
            item.update(answer);
            if(!GameScene.uiLayer.contains(item))
            {
               GameScene.uiLayer.addChild(item);
            }
            i++;
         }
      }
      
      public function generatAns() : void
      {
         var answerI:AnItem = null;
         var i:int = 0;
         while(i < this.answerVec.length)
         {
            answerI = this.answerVec[i];
            answerI.move();
            if(!GameScene.uiLayer.contains(answerI))
            {
               GameScene.uiLayer.addChild(answerI);
            }
            i++;
         }
      }
      
      public function targetPosOf(index:int) : Object
      {
         return {
            "px":this.answerVec[index].bmPos.x + 8,
            "py":this.answerVec[index].bmPos.y + 8
         };
      }
      
      public function set rightIndex(value:int) : void
      {
         this.answerVec[value].rightOrWrong = true;
         var other:int = value == 1 ? 0 : 1;
         this.answerVec[other].rightOrWrong = false;
      }
      
      public function removeAnswerItem() : void
      {
         var item:AnItem = null;
         var i:int = 0;
         while(i < this.answerVec.length)
         {
            item = this.answerVec[i];
            if(Boolean(item) && Boolean(item.parent))
            {
               item.parent.removeChild(item);
            }
            i++;
         }
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.utils.Tween;
import com.yiTian.view.modules.treeDownCL.Model_treeCL;
import com.yiTian.view.modules.treeDownCL.SmallPan;
import flash.display.Bitmap;
import flash.geom.Point;
import flash.utils.setTimeout;
import flashx.textLayout.formats.TextAlign;

class AnItem extends SmallPan
{
   
   private var bmCheck:Bitmap;
   
   private var tf:MyTextField;
   
   private var bmTree:Bitmap;
   
   private var arr:Array = [];
   
   private var type:int;
   
   private var position:Object;
   
   private var tfY:int;
   
   private var isSetPosition:Boolean = false;
   
   public function AnItem()
   {
      super();
      regSource("DaShu_Imgsdm","DaShu_Imgs");
      this.bmTree = new Bitmap();
      this.bmCheck = new Bitmap();
      addChild(this.bmTree);
      addChild(this.bmCheck);
      this.tf = ComponentUtil.getTextField("",this,{
         "realWidth":100,
         "multiline":true,
         "wordWrap":true,
         "align":TextAlign.CENTER
      });
      this.arr.push(this.bmTree,this.tf,this.bmCheck);
   }
   
   override protected function initSource() : void
   {
      if(this.type == 0)
      {
         this.bmTree.bitmapData = ComponentUtil.getBitmapData("Back_TLeft",Global.DaShu_Imgsdm);
      }
      else
      {
         this.bmTree.bitmapData = ComponentUtil.getBitmapData("Back_TRight",Global.DaShu_Imgsdm);
      }
   }
   
   public function initB(posArr:Array, ty:int, posObj:Object) : void
   {
      this.type = ty;
      this.position = posObj;
      super.init(null,function():void
      {
         var obj:Object = null;
         var i:int = 0;
         while(i < posArr.length)
         {
            obj = posArr[i];
            ComponentUtil.setPropertie(arr[i],obj);
            if(i == 1)
            {
               tfY = obj.y;
            }
            i++;
         }
      });
      if(!visible)
      {
         visible = true;
      }
   }
   
   public function get bmPos() : Point
   {
      return localToGlobal(new Point(this.bmCheck.x,this.bmCheck.y));
   }
   
   public function set rightOrWrong(value:Boolean) : void
   {
      var n:int;
      if(!visible)
      {
         visible = true;
      }
      if(!this.bmCheck.visible)
      {
         this.bmCheck.visible = true;
      }
      if(value)
      {
         this.bmCheck.bitmapData = ComponentUtil.getBitmapData("Icon_Dui",Global.DaShu_Imgsdm);
      }
      else
      {
         this.bmCheck.bitmapData = ComponentUtil.getBitmapData("Icon_Cuo",Global.DaShu_Imgsdm);
      }
      n = int(setTimeout(function():void
      {
         bmCheck.visible = false;
         tf.text = Model_treeCL.answerArr[type];
      },2500));
   }
   
   public function update(answer:String) : void
   {
      if(!visible)
      {
         visible = true;
      }
      this.tf.htmlText = answer;
      if(this.tf.textHeight > 20)
      {
         this.tf.y = this.tfY - 10;
      }
      else
      {
         this.tf.y = this.tfY;
      }
   }
   
   public function move() : void
   {
      if(!visible)
      {
         visible = true;
      }
      ComponentUtil.setPropertie(this,{
         "x":this.position.x,
         "y":this.position.y - 80
      });
      Tween.to(this,1900,{
         "x":[this.x,this.position.x],
         "y":[this.y,this.position.y],
         "alpha":[0,1]
      },function():void
      {
         isSetPosition = true;
      });
   }
   
   override protected function resetPosition() : void
   {
      var _x:int = 0;
      if(this.type == 0)
      {
         _x = (Global.stage.stageWidth - 197) / 2 - 297;
      }
      else
      {
         _x = (Global.stage.stageWidth - 197) / 2 + 293;
      }
      ComponentUtil.setPropertie(this,{
         "x":_x,
         "y":this.position.y
      });
   }
}
