package com.yiTian.view.modules.paihang
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.gameUnit.role.LZBmp;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   
   public class PaiHangItem extends Sprite
   {
      
      private static var LEN:int = 10;
      
      private var txtVec:Vector.<MyTextField>;
      
      public var index:int;
      
      private var mouseOverBack:DisplayObject;
      
      private var _isChoose:Boolean;
      
      private var txtProperty:Array = [{
         "defaultText":"",
         "x":0,
         "y":4,
         "realWidth":25,
         "color":14662240
      },{
         "defaultText":"",
         "x":52,
         "y":4,
         "realWidth":150,
         "color":11904647
      },{
         "defaultText":"",
         "x":168,
         "y":4,
         "realWidth":86.2,
         "color":11904647
      },{
         "defaultText":"",
         "x":247,
         "y":4,
         "realWidth":76.2,
         "color":11904647
      },{
         "defaultText":"",
         "x":325,
         "y":4,
         "realWidth":78,
         "color":14662240
      }];
      
      private var txtProperty2:Array = [{
         "defaultText":"",
         "x":0,
         "y":4,
         "realWidth":25,
         "color":14662240
      },{
         "defaultText":"",
         "x":40,
         "y":4,
         "realWidth":80,
         "color":11904647
      },{
         "defaultText":"",
         "x":100,
         "y":4,
         "realWidth":150,
         "color":11904647
      },{
         "defaultText":"",
         "x":257,
         "y":4,
         "realWidth":76.2,
         "color":11904647
      },{
         "defaultText":"",
         "x":325,
         "y":4,
         "realWidth":78,
         "color":14662240
      }];
      
      private var txtMeiLiFlowers:Array = [{
         "defaultText":"",
         "x":0,
         "y":4,
         "realWidth":25,
         "color":16383744
      },{
         "defaultText":"",
         "x":48,
         "y":4,
         "realWidth":115,
         "color":11515029
      },{
         "defaultText":"",
         "x":173,
         "y":4,
         "realWidth":100,
         "color":12400953
      },{
         "defaultText":"",
         "x":310,
         "y":4,
         "realWidth":76.2,
         "color":16383744
      }];
      
      private var LZbmp:LZBmp = new LZBmp();
      
      private var strUrl:String;
      
      private var zhiYeArr:Array;
      
      public function PaiHangItem()
      {
         var txt:MyTextField = null;
         super();
         this.zhiYeArr = [LangConfig.getWord("10036",1),LangConfig.getWord("10037",1),LangConfig.getWord("10038",1),LangConfig.getWord("10039",1)];
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":0,
            "y":27,
            "width":380,
            "height":2
         },Global.Img_Cdm);
         this.mouseOverBack = ComponentUtil.getDisplayObject("Item_Select",this,{
            "width":380,
            "height":29
         });
         this.txtVec = new Vector.<MyTextField>();
         var i:uint = 0;
         while(i < 5)
         {
            txt = ComponentUtil.getTextField(this.txtProperty[i].defaultText,this,{
               "x":this.txtProperty[i].x,
               "y":this.txtProperty[i].y,
               "color":this.txtProperty[i].color
            });
            txt.realWidth = this.txtProperty[i].realWidth;
            txt.align = TextFormatAlign.CENTER;
            this.txtVec.push(txt);
            i++;
         }
         addChild(this.LZbmp);
      }
      
      public function addDia(diaLvl:int, isYearDia:int, huangZLv:int = 0, isHuangZYear:int = 0, isHuiyuan:int = 0, isHuiyuanYear:int = 0, superLan:int = 0, superLanYear:int = 0, isSuperHuang:int = 0) : void
      {
         this.strUrl = "";
         this.LZbmp.bitmapData = null;
         if(UIManager.paiHangPanel.paiHangVO.curPaiHangType != 7)
         {
            this.txtVec[1].realWidth = 120;
         }
         else
         {
            this.txtVec[1].realWidth = 80;
            this.txtVec[2].x = this.txtProperty2[2].x;
         }
         if(Global.pf == "qqgame" || Global.pf == Enum_SPStr.QQ3366)
         {
            if(superLanYear == 0 && superLan > 0)
            {
               this.strUrl = LZBmp.getsuperLan(superLan);
               MassLoader.add(this.strUrl,this.cmp);
               return;
            }
            if(superLan > 0)
            {
               this.strUrl = LZBmp.getsuperLanYear(superLan);
               MassLoader.add(this.strUrl,this.cmp);
               return;
            }
            if(isYearDia == 0 && diaLvl > 0)
            {
               this.strUrl = LZBmp.getLvlUrl(diaLvl);
               MassLoader.add(this.strUrl,this.cmp);
            }
            else if(diaLvl > 0)
            {
               this.strUrl = LZBmp.getYearUrl(diaLvl);
               MassLoader.add(this.strUrl,this.cmp);
            }
         }
         else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isPartUnion() || Enum_SPStr.isUnion(Global.pf))
         {
            if(isHuiyuanYear == 0 && isHuiyuan > 0)
            {
               this.strUrl = LZBmp.getQQHuiYuan(isHuiyuan);
               MassLoader.add(this.strUrl,this.cmp);
            }
            else if(isHuiyuan > 0)
            {
               this.strUrl = LZBmp.getQQHuiYuanYear(isHuiyuan);
               MassLoader.add(this.strUrl,this.cmp);
            }
         }
         else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
         {
            if(Boolean(isSuperHuang))
            {
               if(isHuangZYear == 0 && huangZLv > 0)
               {
                  this.strUrl = LZBmp.getLvlUrl_superH(huangZLv);
                  MassLoader.add(this.strUrl,this.cmp);
               }
               else if(huangZLv > 0)
               {
                  this.strUrl = LZBmp.getYearUrl_superH(huangZLv);
                  MassLoader.add(this.strUrl,this.cmp);
               }
            }
            else if(isHuangZYear == 0 && huangZLv > 0)
            {
               this.strUrl = LZBmp.getLvlUrl_h(huangZLv);
               MassLoader.add(this.strUrl,this.cmp);
            }
            else if(huangZLv > 0)
            {
               this.strUrl = LZBmp.getYearUrl_h(huangZLv);
               MassLoader.add(this.strUrl,this.cmp);
            }
         }
      }
      
      private function cmp(info:Object) : void
      {
         Util.bmdPool[info.url] = (info.content as Bitmap).bitmapData;
         if(this.strUrl == info.url)
         {
            this.LZbmp.bitmapData = (info.content as Bitmap).bitmapData;
         }
         else if(this.strUrl == "")
         {
            this.LZbmp.bitmapData = null;
         }
         else
         {
            Utils.getLoadBitmap(this.strUrl,this.LZbmp.bmp);
         }
         this.align();
      }
      
      private function align() : void
      {
         var _num2:int = 0;
         var _num1:int = 0;
         var _num:int = 0;
         var _n:int = 0;
         if(UIManager.paiHangPanel.paiHangVO.curPaiHangType != 7)
         {
            this.LZbmp.x = this.txtVec[1].x + this.txtVec[1].width / 2 - this.txtVec[1].textWidth / 2 - this.LZbmp.width - 3;
            _num1 = this.txtVec[0].x;
            _num2 = this.txtVec[0].width;
            _num = _num1 + _num2;
            if(this.LZbmp.x < _num)
            {
               _n = _num - this.LZbmp.x;
               this.LZbmp.x += _n;
               this.txtVec[1].x += _n;
            }
         }
         else
         {
            this.LZbmp.x = this.txtVec[2].x + this.txtVec[2].width / 2 - this.txtVec[2].textWidth / 2 - this.LZbmp.width - 3;
            _num1 = this.txtVec[1].x;
            _num2 = this.txtVec[1].width;
            _num = _num1 + _num2;
            if(this.LZbmp.x < _num)
            {
               _n = _num - this.LZbmp.x;
               this.LZbmp.x += _n;
               this.txtVec[2].x += _n;
            }
         }
         this.LZbmp.y = 2;
      }
      
      public function update(arr:Array) : void
      {
         var i:int = 0;
         var phVO:PaiHangVO = null;
         var ind:int = 0;
         var str:String = null;
         var strL:int = 0;
         var _nn:Number = NaN;
         this.buttonMode = true;
         this.onOverOut(true);
         phVO = UIManager.paiHangPanel.paiHangVO;
         var _heroNickName:String = GameUnitManager.hero.nickName;
         if(phVO.curPaiHangType == 7)
         {
            this.txtVec[0].text = arr[0].toString();
            this.txtVec[1].text = arr[1].toString();
            this.txtVec[2].text = Model_heFu.repNameByHero(arr[2].toString());
         }
         else
         {
            this.txtVec[0].text = arr[0].toString();
            this.txtVec[1].text = Model_heFu.repNameByHero(arr[1].toString());
         }
         if(phVO.curPaiHangType < 6)
         {
            i = 0;
            while(i < this.txtVec.length)
            {
               this.txtVec[i].x = this.txtProperty[i].x;
               this.txtVec[i].realWidth = this.txtProperty[i].realWidth;
               i++;
            }
            this.txtVec[2].text = this.zhiYeArr[Enum_job.getBaseJob(arr[2]) - 1].toString();
            ind = phVO.curPaiHangType == 1 ? 4 : 5;
            this.txtVec[4].text = arr[ind].toString();
            if(Boolean(arr[3]))
            {
               this.txtVec[3].text = arr[3].toString();
            }
            else
            {
               this.txtVec[3].text = LangConfig.getWord("10015",1);
            }
            if(phVO.curPaiHangType == 3)
            {
               str = this.txtVec[4].text;
               strL = str.length;
               if(strL >= 8)
               {
                  _nn = 2 * (strL - 6.5);
                  this.txtVec[4].x = 325 - _nn;
               }
            }
         }
         else if(phVO.curPaiHangType == 6)
         {
            i = 0;
            while(i < this.txtVec.length)
            {
               this.txtVec[i].x = this.txtProperty[i].x;
               this.txtVec[i].realWidth = this.txtProperty[i].realWidth;
               i++;
            }
            this.txtVec[2].text = arr[2].toString();
            this.txtVec[4].text = arr[4].toString();
            if(Boolean(arr[3]))
            {
               this.txtVec[3].text = arr[3].toString();
            }
            else
            {
               this.txtVec[3].text = LangConfig.getWord("10015",1);
            }
         }
         else if(phVO.curPaiHangType == 7)
         {
            i = 0;
            while(i < this.txtVec.length)
            {
               this.txtVec[i].x = this.txtProperty2[i].x;
               this.txtVec[i].realWidth = this.txtProperty2[i].realWidth;
               i++;
            }
            this.txtVec[4].text = arr[4].toString();
            if(Boolean(arr[3]))
            {
               this.txtVec[3].text = arr[3].toString();
            }
            else
            {
               this.txtVec[3].text = LangConfig.getWord("10015",1);
            }
         }
         else if(phVO.curPaiHangType == 8 || phVO.curPaiHangType == 9)
         {
            i = 0;
            while(i < this.txtMeiLiFlowers.length)
            {
               this.txtVec[i].x = this.txtMeiLiFlowers[i].x;
               this.txtVec[i].realWidth = this.txtMeiLiFlowers[i].realWidth;
               i++;
            }
            this.txtVec[2].text = arr[3] + "朵";
            this.txtVec[3].text = arr[5].toString();
         }
         this.txtVec[4].visible = true;
         this.txtVec[2].x = this.txtProperty[2].x;
         if(phVO.curPaiHangType == 6 || phVO.curPaiHangType == 7)
         {
            LEN = 11;
         }
         else
         {
            LEN = 15;
         }
         if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Global.pf == Enum_SPStr.QQGAME || Enum_SPStr.isIwan(Global.pf) || Global.pf == Enum_SPStr.QQJIA || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
         {
            this.addDia(arr[arr.length - LEN],arr[arr.length - (LEN - 1)],arr[arr.length - (LEN - 2)],arr[arr.length - (LEN - 3)],arr[arr.length - (LEN - 4)],arr[arr.length - (LEN - 5)],arr[arr.length - (LEN - 6)],arr[arr.length - (LEN - 7)],arr[arr.length - 1]);
         }
         if(phVO.curPaiHangType == 8 || phVO.curPaiHangType == 9)
         {
            this.txtVec[4].visible = false;
            this.txtVec[2].x = this.txtMeiLiFlowers[2].x;
         }
      }
      
      public function reset() : void
      {
         this.LZbmp.bitmapData = null;
         var i:uint = 0;
         while(i < this.txtVec.length)
         {
            this.txtVec[i].text = "";
            i++;
         }
         this.choose = false;
         this.buttonMode = false;
         this.onOverOut(false);
      }
      
      private function onOutHandler(e:MouseEvent) : void
      {
         if(this._isChoose)
         {
            return;
         }
         this.mouseOverBack.alpha = 0;
      }
      
      private function onOverHandler(e:MouseEvent) : void
      {
         if(this._isChoose)
         {
            return;
         }
         this.mouseOverBack.alpha = 1;
      }
      
      public function set choose(value:Boolean) : void
      {
         if(value)
         {
            this.mouseOverBack.alpha = 1;
         }
         else
         {
            this.mouseOverBack.alpha = 0;
         }
         this._isChoose = value;
      }
      
      public function get isChoose() : Boolean
      {
         return this._isChoose;
      }
      
      private function onOverOut(value:Boolean) : void
      {
         if(value)
         {
            this.mouseOverBack.addEventListener(MouseEvent.MOUSE_OVER,this.onOverHandler);
            this.mouseOverBack.addEventListener(MouseEvent.MOUSE_OUT,this.onOutHandler);
         }
         else
         {
            this.mouseOverBack.removeEventListener(MouseEvent.MOUSE_OVER,this.onOverHandler);
            this.mouseOverBack.removeEventListener(MouseEvent.MOUSE_OVER,this.onOutHandler);
         }
      }
   }
}

