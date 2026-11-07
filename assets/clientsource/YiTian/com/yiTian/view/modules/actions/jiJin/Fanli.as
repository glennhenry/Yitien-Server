package com.yiTian.view.modules.actions.jiJin
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.Canvas;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.chatM.TestScroll;
   import com.yiTian.view.modules.fund.FundConfig;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   
   public class Fanli extends Sprite
   {
      
      private static var nowArr:Array = [];
      
      private var itemVec:Vector.<Item>;
      
      private var con:TestScroll;
      
      private var conVa:Canvas;
      
      private var contain:Sprite;
      
      private var lvlTxt:MyTextField;
      
      private var rfExtra:MyTextField;
      
      public function Fanli()
      {
         var bm:Bitmap;
         var sp:Sprite = null;
         this.itemVec = new Vector.<Item>();
         super();
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":0,
            "y":0,
            "width":490,
            "height":162
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_TitleBule",[5,5,2,2],this,{
            "x":3,
            "y":4,
            "width":484,
            "height":28
         },Global.Img_Cdm);
         ComponentUtil.getTextField("天数",this,{
            "x":50,
            "y":7,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("返还基金",this,{
            "x":150,
            "y":7,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.rfExtra = ComponentUtil.getTextField("白金武魂奖励",this,{
            "x":241,
            "y":7,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.lvlTxt = ComponentUtil.getTextField("00级",this,{
            "x":241 + 90,
            "y":7,
            "color":16764206,
            "size":12,
            "leading":0
         });
         sp = new Sprite();
         addChild(sp);
         ComponentUtil.setPropertie(sp,{
            "x":361,
            "y":7
         });
         bm = ComponentUtil.getBitmap("Text_CWWuHun",sp,{
            "x":0,
            "y":0
         },Global.JiJin_Imgsdm);
         sp.buttonMode = true;
         sp.addEventListener(MouseEvent.CLICK,function():void
         {
            ChongZhi.isCheAll = true;
            UIManager.yuanBaoXiang.visible = true;
         });
         TipManager.bind(sp,FundMter.desCripJJ);
         this.contain = new Sprite();
         addChild(this.contain);
         this.conVa = new Canvas(479,124);
         ComponentUtil.setPropertie(this.conVa,{
            "x":7,
            "y":36
         });
         this.conVa.scrollAutoType = ScrollAutoType.REMAIN;
         addChild(this.conVa);
         this.conVa.addChild(this.contain);
      }
      
      public static function get awardStatusGet() : Boolean
      {
         var item:Item = null;
         for each(item in nowArr)
         {
            if(item.btnStatus)
            {
               return true;
            }
         }
         return false;
      }
      
      private function link(e:TextEvent) : void
      {
         ChongZhi.isCheAll = true;
         UIManager.yuanBaoXiang.visible = true;
      }
      
      public function getAward(_index:int) : void
      {
         var item:Item = null;
         if(Boolean(nowArr.length))
         {
            item = nowArr[_index - 1];
            item.getAward();
         }
         if(!awardStatusGet)
         {
            FundConfig.removeEff();
         }
      }
      
      private function reset() : void
      {
         var item:Item = null;
         if(Boolean(nowArr.length))
         {
            for each(item in nowArr)
            {
               item.dispose();
            }
         }
         while(Boolean(nowArr.length))
         {
            nowArr.shift();
         }
      }
      
      public function update(_type:int, _lvl:int, _dataArr:Array, dys:int) : void
      {
         var It:Item = null;
         var _status:int = 0;
         this.lvlTxt.text = _lvl + "级";
         var len:int = int(_dataArr.length);
         this.reset();
         var _arr:Array = this.handleArr(_dataArr);
         if(_arr.length > 5)
         {
            _arr.pop();
         }
         var i:int = 0;
         while(i < _arr.length)
         {
            It = Item.instance;
            _status = int(_arr[i]);
            It.update(i + 1,_status,dys,_lvl,_type);
            nowArr.push(It);
            this.contain.addChild(It);
            ComponentUtil.setPropertie(It,{
               "x":0,
               "y":0 + 31 * i
            });
            i++;
         }
         this.conVa.align();
      }
      
      private function handleArr(_arr:Array) : Array
      {
         var _num:int = 0;
         var i:int = 0;
         var s:int = 0;
         if(!_arr || !_arr.length)
         {
            return FundMter.daysArr;
         }
         var len:int = int(FundMter.daysArr.length);
         if(_arr.length > 0 && _arr.length < 5)
         {
            _num = 5 - _arr.length;
            i = int(_arr.length);
            while(i < len)
            {
               s = int(FundMter.daysArr[i]);
               _arr.push(s);
               i++;
            }
            return _arr;
         }
         return _arr;
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.Data_lib;
import com.yiTian.net.message.cg.FundCGMessage;
import com.yiTian.utils.HtmlUtil;
import com.yiTian.view.modules.actions.jiJin.FundMter;
import flash.display.Sprite;
import flash.utils.Dictionary;
import flashx.textLayout.formats.TextAlign;

class Item extends Sprite
{
   
   private static var pool:Array = [];
   
   private var jjTf:MyTextField;
   
   private var tfDays:MyTextField;
   
   private var percentTf:MyTextField;
   
   private var btn:Button;
   
   private var _index:int;
   
   private var jiJin:int;
   
   private var perArr:Array;
   
   public function Item()
   {
      this.perArr = [0,0.1,0.3,0.5];
      super();
      ComponentUtil.getScaleBitmap("Back_Green_List",[5,5,1,1],this,{
         "x":0,
         "y":0,
         "width":460,
         "height":30
      },Global.Img_Cdm);
      this.tfDays = ComponentUtil.getTextField("第00天返利",this,{
         "x":19,
         "y":5,
         "color":11523767,
         "size":12,
         "leading":0
      });
      this.jjTf = ComponentUtil.getTextField("0000基金",this,{
         "x":140,
         "y":5,
         "color":13424242,
         "size":12,
         "leading":0
      });
      this.percentTf = ComponentUtil.getTextField("000%",this,{
         "x":241,
         "y":5,
         "color":851218,
         "size":12,
         "leading":0,
         "realWidth":64,
         "align":TextAlign.CENTER
      });
      this.btn = ComponentUtil.getButton("点击领取","Button_RedFive",this,{
         "x":347,
         "y":1,
         "textColor":16184781,
         "callBack":function():void
         {
            FundMter._index = _index;
            FundMter.getJiJing = jiJin;
            FundCGMessage.CG_GET_REWARD(1,_index);
         }
      },Global.Img_Cdm);
   }
   
   public static function get instance() : Item
   {
      if(Boolean(pool.length))
      {
         return pool.pop();
      }
      return new Item();
   }
   
   public function update(_types:int, _status:int, _days:int, lvl:int, _type:int) : void
   {
      var jjPer:int = 0;
      this._index = _types;
      var _dys:int = int(FundMter.EnumDays[_types - 1]);
      if(_dys == 0)
      {
         this.tfDays.text = "当天返利";
      }
      else
      {
         this.tfDays.text = "第" + _dys + "天返利";
      }
      var dic:Dictionary = Data_lib.fundFanLi;
      var jj:int = int(Data_lib.fundFanLi[_dys][_type - 1]);
      this.jjTf.text = jj + "基金";
      if(lvl == 0)
      {
         jjPer = 0;
      }
      else
      {
         jjPer = int(FundMter.getDicItem(jj,_type,lvl));
      }
      this.jiJin = jj + jjPer;
      this.percentTf.htmlText = HtmlUtil.font(jjPer.toString(),FundMter.colorArr[lvl]);
      if(_status == 0)
      {
         this.btn.label = "可领取";
         this.btn.enabled = true;
      }
      else if(_status == 1)
      {
         this.btn.label = "已领取";
         this.btn.enabled = false;
      }
      else
      {
         this.btn.enabled = false;
         this.btn.label = _dys - _days + "天后可领取";
      }
   }
   
   public function get btnStatus() : Boolean
   {
      return this.btn.enabled;
   }
   
   public function getAward() : void
   {
      this.btn.label = "已领取";
      this.btn.enabled = false;
   }
   
   public function dispose() : void
   {
      if(Boolean(parent))
      {
         parent.removeChild(this);
      }
      pool.push(this);
   }
}
