package com.yiTian.view.modules.actions.leijichongzhi
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.net.message.cg.LeiJiChongZhiCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class LeiJiChongZhiPan extends Panel123
   {
      
      private static var btnIndex:int = 0;
      
      private var closeBtn:Button;
      
      private var getBtn1:Button;
      
      private var getBtn2:Button;
      
      private var getBtn3:Button;
      
      private var getBtn4:Button;
      
      private var getBtn5:Button;
      
      private var getBtn6:Button;
      
      private var getBtn7:Button;
      
      private var myTextField:MyTextField;
      
      private var btnArr:Array = new Array();
      
      private var imgArr:Array = [];
      
      private var _yuanbaoArr:Array = [];
      
      private var len:int = 7;
      
      private var index:int = 1;
      
      private var nextBtn:Button;
      
      private var prevBtn:Button;
      
      private var prevBack:Bitmap;
      
      private var nextBack:Bitmap;
      
      private var startIndex:int;
      
      private var endIndex:int;
      
      private var pageNum:int;
      
      private var numberArr:Array = ["一","二","三","四","五","六","七","八","九","十"];
      
      private var _btnStateArr:Array = [];
      
      private var _effArr:Array = [];
      
      private var awardNum:int = 0;
      
      private var gridCon:Sprite;
      
      private var leftOrRight:String = "left";
      
      private var dangTFArr:Array = [];
      
      private var firstOpen:Boolean = true;
      
      private var _init:Boolean = false;
      
      private var _money:int;
      
      public function LeiJiChongZhiPan()
      {
         super();
         regResource("lang/ch/leijichongzhi.swf","leijichongzhi_Imgsdm");
      }
      
      public static function get instance() : LeiJiChongZhiPan
      {
         return Singleton.getInstance(LeiJiChongZhiPan);
      }
      
      override protected function initUI2() : void
      {
         var j:int;
         var i:int;
         var tf:MyTextField = null;
         var dangtf:Bitmap = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":795,
            "height":547
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":41,
            "width":744,
            "height":497
         },Global.Img_Cdm);
         move = new Rectangle(0,0,745,35);
         this.closeBtn = ComponentUtil.getButton("","Button_Close",this,{
            "x":759,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         this.closeBtn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            visible = false;
         });
         ComponentUtil.getBitmap("Back_NCWS",this,{
            "x":35,
            "y":50
         },Global.leijichongzhi_Imgsdm);
         ComponentUtil.getBitmap("Title_NCWS",this,{
            "x":316,
            "y":5
         },Global.leijichongzhi_Imgsdm);
         ComponentUtil.getBitmap("Back_JDT",this,{
            "x":58,
            "y":419
         },Global.leijichongzhi_Imgsdm);
         this.gridCon = new Sprite();
         addChild(this.gridCon);
         this.gridCon.graphics.beginFill(16711680,0);
         this.gridCon.graphics.drawRect(0,0,795,547);
         this.gridCon.graphics.endFill();
         this.gridCon.mask = this.drawMask();
         this.getBtn1 = ComponentUtil.getButton("未领取","Button_NCWS",this,{
            "x":101,
            "y":470,
            "textColor":16771436,
            "callBack":this.onClickHandle
         },Global.leijichongzhi_Imgsdm);
         this.getBtn2 = ComponentUtil.getButton("未领取","Button_NCWS",this,{
            "x":188,
            "y":470,
            "textColor":16771436,
            "callBack":this.onClickHandle
         },Global.leijichongzhi_Imgsdm);
         this.getBtn3 = ComponentUtil.getButton("未领取","Button_NCWS",this,{
            "x":276,
            "y":470,
            "textColor":16771436,
            "callBack":this.onClickHandle
         },Global.leijichongzhi_Imgsdm);
         this.getBtn4 = ComponentUtil.getButton("未领取","Button_NCWS",this,{
            "x":362,
            "y":470,
            "textColor":16771436,
            "callBack":this.onClickHandle
         },Global.leijichongzhi_Imgsdm);
         this.getBtn5 = ComponentUtil.getButton("未领取","Button_NCWS",this,{
            "x":449,
            "y":470,
            "textColor":16771436,
            "callBack":this.onClickHandle
         },Global.leijichongzhi_Imgsdm);
         this.getBtn6 = ComponentUtil.getButton("未领取","Button_NCWS",this,{
            "x":536,
            "y":470,
            "textColor":16771436,
            "callBack":this.onClickHandle
         },Global.leijichongzhi_Imgsdm);
         this.getBtn7 = ComponentUtil.getButton("未领取","Button_NCWS",this,{
            "x":623,
            "y":470,
            "textColor":16771436,
            "callBack":this.onClickHandle
         },Global.leijichongzhi_Imgsdm);
         ComponentUtil.getBitmap("Text_Qin",this,{
            "x":90,
            "y":83
         },Global.leijichongzhi_Imgsdm);
         ComponentUtil.getTextField("注:只有领取完整档所有奖励才可领取下档奖励(下档奖励充值数重新计算)。",this,{
            "x":90,
            "y":138,
            "color":16711680,
            "size":12,
            "leading":4,
            "realWidth":180,
            "wordWrap":true
         });
         ComponentUtil.getTextField("已充值元宝数：",this,{
            "x":47,
            "y":513,
            "color":16756736,
            "size":12,
            "leading":0
         });
         this.myTextField = ComponentUtil.getTextField("",this,{
            "x":132,
            "y":513,
            "color":65280,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Line_JDT",this,{
            "x":62,
            "y":422
         },Global.leijichongzhi_Imgsdm);
         j = 0;
         while(j < this.len)
         {
            ComponentUtil.getBitmap("Hand_JDT",this,{
               "x":130 + j * 87,
               "y":415
            },Global.leijichongzhi_Imgsdm);
            j++;
         }
         this.nextBack = ComponentUtil.getBitmap("DK_ZuoYou",this,{
            "x":702,
            "y":270
         },Global.leijichongzhi_Imgsdm);
         this.prevBack = ComponentUtil.getBitmap("DK_ZuoYou",this,{
            "x":61,
            "y":270
         },Global.leijichongzhi_Imgsdm);
         this.prevBtn = ComponentUtil.getButton("","Button_Zuo",this,{
            "x":63,
            "y":276,
            "textColor":16771436,
            "callBack":this.prevPage
         },Global.leijichongzhi_Imgsdm);
         this.nextBtn = ComponentUtil.getButton("","Button_You",this,{
            "x":706,
            "y":276,
            "textColor":16771436,
            "callBack":this.nextPage
         },Global.leijichongzhi_Imgsdm);
         this.prevBtn.visible = false;
         this.prevBack.visible = false;
         i = 0;
         while(i < this.len)
         {
            tf = ComponentUtil.getTextField("1000元宝",this,{
               "x":94 + i * 88,
               "y":436,
               "color":16777215,
               "size":12,
               "leading":0
            });
            this._yuanbaoArr.push(tf);
            dangtf = ComponentUtil.getBitmap("dangshu" + i,this,{
               "x":364,
               "y":50
            },Global.leijichongzhi_Imgsdm);
            this.dangTFArr.push(dangtf);
            dangtf.visible = false;
            i++;
         }
         this.dangTFArr[0].visible = true;
         this.getBtn1.enabled = false;
         this.getBtn2.enabled = false;
         this.getBtn3.enabled = false;
         this.getBtn4.enabled = false;
         this.getBtn5.enabled = false;
         this.getBtn6.enabled = false;
         this.getBtn7.enabled = false;
         this.getBtn1.name = "btn1";
         this.getBtn2.name = "btn2";
         this.getBtn3.name = "btn3";
         this.getBtn4.name = "btn4";
         this.getBtn5.name = "btn5";
         this.getBtn6.name = "btn6";
         this.getBtn7.name = "btn7";
         this.btnArr = [this.getBtn1,this.getBtn2,this.getBtn3,this.getBtn4,this.getBtn5,this.getBtn6,this.getBtn7];
         this.pageNum = Data_lib.leijichongzhi.getLength() / this.len;
         if(this.pageNum <= 1)
         {
            this.nextBtn.visible = false;
            this.nextBack.visible = false;
         }
         this.updateGridData();
         this._init = true;
         if(this._init && Boolean(this._btnStateArr.length))
         {
            this.update(this._btnStateArr,this._money);
         }
      }
      
      private function showDangShuTF() : void
      {
         var i:int = 0;
         while(i < this.len)
         {
            if(i == this.index - 1)
            {
               this.dangTFArr[i].visible = true;
            }
            else
            {
               this.dangTFArr[i].visible = false;
            }
            i++;
         }
      }
      
      private function drawMask() : Shape
      {
         var mask:Shape = new Shape();
         addChild(mask);
         mask.graphics.beginFill(16711680,1);
         mask.graphics.drawRect(100,50,600,400);
         mask.graphics.endFill();
         return mask;
      }
      
      private function prevPage(e:MouseEvent) : void
      {
         this.leftOrRight = "left";
         --this.index;
         this.showDangShuTF();
         this.updateGridData();
         this.updateButtonState();
         if(this.index <= 1)
         {
            this.prevBtn.visible = false;
            this.prevBack.visible = false;
         }
         else
         {
            this.prevBtn.visible = true;
            this.prevBack.visible = true;
         }
         if(this.index < this.pageNum)
         {
            this.nextBtn.visible = true;
            this.nextBack.visible = true;
         }
      }
      
      private function nextPage(e:MouseEvent) : void
      {
         this.leftOrRight = "right";
         ++this.index;
         this.showDangShuTF();
         this.updateGridData();
         this.updateButtonState();
         if(this.index >= this.pageNum)
         {
            this.nextBtn.visible = false;
            this.nextBack.visible = false;
         }
         else
         {
            this.nextBtn.visible = true;
            this.nextBack.visible = true;
         }
         if(this.index > 1)
         {
            this.prevBtn.visible = true;
            this.prevBack.visible = true;
         }
      }
      
      private function updateGridData() : void
      {
         var i:int;
         var leng1:int;
         var next:Function;
         var next1:Function;
         var leng2:int = 0;
         var myGrid:View_Grid = null;
         var sp:Sprite = null;
         var count:int = 0;
         var _giftArr:Array = null;
         var len2:int = 0;
         var listSp:Sprite = null;
         var m:int = 0;
         var grid:View_Grid = null;
         var __giftArr:Array = null;
         var _type:int = 0;
         var _id:int = 0;
         var _count:int = 0;
         var _addEff:int = 0;
         var voI:Vo_item = null;
         var voE:Vo_equip = null;
         var ef:Effect = null;
         this.startIndex = (this.index - 1) * this.len;
         this.endIndex = this.index * this.len;
         this.disposeGridData();
         this._effArr = [];
         i = this.startIndex;
         while(i < this.endIndex)
         {
            _giftArr = Data_lib.leijichongzhi[i + 1][3].split(",");
            this.imgArr[i - this.startIndex] = [];
            len2 = int(_giftArr.length);
            listSp = new Sprite();
            this.gridCon.addChild(listSp);
            if(!this.firstOpen)
            {
               if(this.leftOrRight == "left")
               {
                  listSp.x = 50;
               }
               else if(this.leftOrRight == "right")
               {
                  listSp.x = 720;
               }
            }
            else
            {
               listSp.x = 117 + (i - this.startIndex) * 87;
            }
            m = 0;
            while(m < len2)
            {
               grid = new View_Grid();
               grid.set_bmp_bg();
               grid.set_bmp_over();
               grid.set_bmp_select();
               grid.set_tf_count(true,true,true);
               grid.y = 370 - m * 45;
               listSp.addChild(grid);
               __giftArr = (_giftArr[m] as String).split("_");
               _type = int(__giftArr[0]);
               _id = int(__giftArr[1]);
               _count = int(__giftArr[2]);
               _addEff = int(__giftArr[3]);
               if(_type == 1)
               {
                  voI = new Vo_item();
                  voI.id = _id;
                  voI.Init_lib();
                  grid.vo = voI;
                  grid.count = _count;
               }
               else if(_type == 2)
               {
                  voE = new Vo_equip();
                  voE.id = _id;
                  voE.Init_lib();
                  grid.vo = voE;
                  grid.count = _count;
               }
               this.imgArr[i - this.startIndex].push(grid);
               if(Boolean(_addEff))
               {
                  ef = EffectManager.addEffect("35180",grid,1000,42,42,true);
                  ef.scaleX = 0.5;
                  ef.scaleY = 0.5;
                  this._effArr.push(ef);
               }
               m++;
            }
            i++;
         }
         if(this.firstOpen)
         {
            this.firstOpen = false;
            return;
         }
         leng1 = int(this.imgArr.length);
         count = 0;
         if(this.leftOrRight == "left")
         {
            next = function():void
            {
               if(count < gridCon.numChildren)
               {
                  sp = gridCon.getChildAt(count) as Sprite;
                  Tween.to(sp,100 + 50 * count,{"x":[sp.x,117 + count * 87]},function():void
                  {
                     ++count;
                     next();
                  });
               }
            };
            next();
         }
         else
         {
            next1 = function():void
            {
               if(count >= 0)
               {
                  sp = gridCon.getChildAt(count) as Sprite;
                  Tween.to(sp,400 - 50 * count,{"x":[sp.x,117 + count * 87]},function():void
                  {
                     --count;
                     next1();
                  });
               }
            };
            count = this.gridCon.numChildren - 1;
            next1();
         }
      }
      
      private function disposeGridData() : void
      {
         var gridLen:int = 0;
         var i:int = 0;
         var sp:Sprite = null;
         var glen:int = 0;
         var j:int = 0;
         var grid:View_Grid = null;
         var effLen:int = 0;
         var k:int = 0;
         var eff:Effect = null;
         if(Boolean(this.gridCon))
         {
            gridLen = this.gridCon.numChildren;
            i = gridLen - 1;
            while(i >= 0)
            {
               sp = this.gridCon.getChildAt(i) as Sprite;
               glen = sp.numChildren;
               j = glen - 1;
               while(j >= 0)
               {
                  grid = sp.getChildAt(j) as View_Grid;
                  sp.removeChild(grid);
                  grid.empty();
                  j--;
               }
               Tween.stop(sp);
               this.gridCon.removeChild(sp);
               sp = null;
               i--;
            }
         }
         if(Boolean(this._effArr.length))
         {
            effLen = int(this._effArr.length);
            k = effLen - 1;
            while(k >= 0)
            {
               eff = this._effArr[k];
               EffectManager.removeEffect(eff);
               k--;
            }
         }
      }
      
      private function onClickHandle(e:MouseEvent) : void
      {
         var btnName:String = e.target.name;
         btnIndex = int(btnName.substr(3));
         LeiJiChongZhiCGMessage.CG_LJCZ_GETAWARD(this.index,btnIndex);
      }
      
      public function update(arr:Array, money:int) : void
      {
         var singleArr:Array = null;
         var n:int = 0;
         this._btnStateArr = arr;
         this._money = money;
         if(!this._init)
         {
            return;
         }
         var moneyTxt:String = money.toString();
         this.myTextField.text = moneyTxt;
         var isOut:Boolean = false;
         var i:int = 0;
         while(i < this.pageNum)
         {
            singleArr = this._btnStateArr[i];
            n = 0;
            while(n < 7)
            {
               if(singleArr[n] == 1)
               {
                  this.index = i + 1;
                  isOut = true;
                  break;
               }
               n++;
            }
            if(isOut)
            {
               break;
            }
            i++;
         }
         this.updateButtonState();
         this.showDangShuTF();
         this.updateGridData();
         if(this.index == 1)
         {
            this.prevBack.visible = false;
            this.prevBtn.visible = false;
         }
         else if(this.index < this.pageNum)
         {
            this.prevBack.visible = true;
            this.prevBtn.visible = true;
            this.nextBack.visible = true;
            this.nextBtn.visible = true;
         }
         else if(this.index == this.pageNum)
         {
            this.prevBack.visible = true;
            this.prevBtn.visible = true;
            this.nextBack.visible = false;
            this.nextBtn.visible = false;
         }
         if(this.pageNum == 1)
         {
            this.prevBack.visible = false;
            this.prevBtn.visible = false;
            this.nextBack.visible = false;
            this.nextBtn.visible = false;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            LeiJiChongZhiCGMessage.CG_LJCZ_SHOWPANEL();
         }
      }
      
      public function getAward(dangshu:int, idx:int) : void
      {
         var curBtn:Button = null;
         if(Boolean(this._btnStateArr.length))
         {
            this._btnStateArr[dangshu - 1][idx - 1] = 2;
            curBtn = this.btnArr[idx - 1];
            curBtn.enabled = false;
            curBtn.label = "已领取";
            --this.awardNum;
            this.giftFly(idx);
            if(this.awardNum <= 0)
            {
               LeiJiChongZhiBtn.removeEff();
            }
         }
      }
      
      private function updateButtonState() : void
      {
         var singleArr:Array = null;
         var n:int = 0;
         var btn:Button = null;
         var i:int = 0;
         while(i < this.pageNum)
         {
            if(i == this.index - 1)
            {
               singleArr = this._btnStateArr[i];
               n = 0;
               while(n < 7)
               {
                  btn = this.btnArr[n];
                  this._yuanbaoArr[n].text = "充值" + Data_lib.leijichongzhi[i * this.len + n + 1][1] + "元宝";
                  switch(singleArr[n])
                  {
                     case 0:
                        btn.enabled = false;
                        btn.label = "未领取";
                        break;
                     case 1:
                        btn.enabled = true;
                        btn.label = "可领取";
                        ++this.awardNum;
                        break;
                     case 2:
                        btn.enabled = false;
                        btn.label = "已领取";
                  }
                  n++;
               }
               break;
            }
            i++;
         }
      }
      
      public function giftFly(idx:int) : void
      {
         var giftGrid:View_Grid = null;
         var gridLen:int = int(this.imgArr[idx - 1].length);
         var i:int = 0;
         while(i < gridLen)
         {
            if(Boolean(this.imgArr[idx - 1][i]))
            {
               giftGrid = this.imgArr[idx - 1][i] as View_Grid;
            }
            if(Boolean(giftGrid))
            {
               Tween.gridToBagBezierFuncDef(giftGrid);
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

