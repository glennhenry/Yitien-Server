package com.yiTian.view.modules.AiDeBaoBao
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.view.Panel;
   
   public class View_AiDeBaoBao_PaiHang extends Panel
   {
      
      private static var _instance:View_AiDeBaoBao_PaiHang;
      
      private var itemArray:Array;
      
      public function View_AiDeBaoBao_PaiHang()
      {
         super();
         super.init();
      }
      
      public static function get instance() : View_AiDeBaoBao_PaiHang
      {
         if(!_instance)
         {
            _instance = new View_AiDeBaoBao_PaiHang();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         var i:int = 0;
         var item:RankItem = null;
         ComponentUtil.getBitmap("Back_Rank",this,{
            "x":0,
            "y":0
         },Global.ADBB_Imgsdm);
         this.itemArray = [];
         i = 0;
         while(i < 5)
         {
            item = new RankItem();
            item.rank = i + 1;
            item.x = 16;
            item.y = 58 + i * 25;
            addChild(item);
            this.itemArray.push(item);
            item.visible = false;
            i++;
         }
         bAutoRemove = false;
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - width;
         y = 200;
      }
      
      public function setRank(arr:Array) : void
      {
         if(!Global.ADBB_Imgsdm)
         {
            return;
         }
         var i:int = 0;
         while(i < 5)
         {
            if(Boolean(arr[i]))
            {
               this.itemArray[i].visible = true;
               this.itemArray[i].name1 = arr[i][0];
               this.itemArray[i].name2 = arr[i][1];
               this.itemArray[i].costTime = arr[i][2];
            }
            else
            {
               this.itemArray[i].visible = false;
            }
            i++;
         }
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import flash.display.Sprite;

class RankItem extends Sprite
{
   
   private var _rank:MyTextField;
   
   private var _name1:MyTextField;
   
   private var _name2:MyTextField;
   
   private var _costTime:MyTextField;
   
   public function RankItem()
   {
      super();
      ComponentUtil.getBitmap("Icon_Heart",this,{
         "x":113,
         "y":2
      },Global.ADBB_Imgsdm);
      ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
         "x":0,
         "y":20,
         "width":265,
         "height":2
      },Global.Img_Cdm);
      this._rank = ComponentUtil.getTextField("0",this,{
         "x":10,
         "y":0,
         "color":13424242,
         "size":12,
         "leading":0
      });
      this._name1 = ComponentUtil.getTextField("玩家中文名称",this,{
         "x":109,
         "y":0,
         "color":327424,
         "size":12,
         "leading":0
      },"right");
      this._name2 = ComponentUtil.getTextField("玩家中文名称",this,{
         "x":129,
         "y":0,
         "color":14566855,
         "size":12,
         "leading":0
      });
      this._costTime = ComponentUtil.getTextField("00:00",this,{
         "x":221,
         "y":0,
         "color":13424242,
         "size":12,
         "leading":0
      });
      this.visible = false;
   }
   
   public function get rank() : int
   {
      return int(this._rank.text);
   }
   
   public function set rank(value:int) : void
   {
      this._rank.text = value.toString();
   }
   
   public function get name1() : String
   {
      return this._name1.text;
   }
   
   public function set name1(value:String) : void
   {
      this._name1.text = value;
   }
   
   public function get name2() : String
   {
      return this._name2.text;
   }
   
   public function set name2(value:String) : void
   {
      this._name2.text = value;
   }
   
   public function set costTime(value:int) : void
   {
      this._costTime.text = String(int(value / 60)) + ":" + String(value % 60 + 100).substr(1,2);
   }
}
