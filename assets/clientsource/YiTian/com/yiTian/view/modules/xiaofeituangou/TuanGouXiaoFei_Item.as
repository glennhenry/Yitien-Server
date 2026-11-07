package com.yiTian.view.modules.xiaofeituangou
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.XiaoFeiTuanGouCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextFormatAlign;
   
   public class TuanGouXiaoFei_Item extends Sprite
   {
      
      private var _grid:View_Grid;
      
      private var _xiaoFeiTF:MyTextField;
      
      private var _hadXiaoFeiTF:MyTextField;
      
      private var _xianGouTF:MyTextField;
      
      private var _button:Button;
      
      private var _line:Shape;
      
      private var _gridVec:Vector.<View_Grid>;
      
      private var _numTFArr:Array;
      
      private var _curKuaFuTF:MyTextField;
      
      private var _vo:TuanGouVo;
      
      private var typeArr:Array = ["今日充值","今日消费","秘境消费","商城消费","原  价"];
      
      private var hadTypeArr:Array = ["已 充 值 ","已 消 费 ","现  价"];
      
      private var _bmArr:Array = [];
      
      private var _xianjia:int;
      
      private var itemName:String;
      
      private var _upLineNum:int;
      
      private var _gridCon:Sprite;
      
      private var _kuaFuNum:int = -1;
      
      private var _isShowTip:Boolean = false;
      
      public function TuanGouXiaoFei_Item()
      {
         var i:int = 0;
         var tempGrid:View_Grid = null;
         var tf:MyTextField = null;
         var bm:Bitmap = null;
         super();
         ComponentUtil.getBitmap("Back_TGJLD",this,{
            "x":0,
            "y":0
         },Global.XFTGdm);
         this._grid = new View_Grid(true);
         addChild(this._grid);
         this._grid.x = 12;
         this._grid.y = 13;
         this._grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
         this._grid.set_bmp_over(true,View_Grid.GRID_BIGGEST_OVER);
         this._grid.set_tf_count(true,false,true);
         this._xiaoFeiTF = ComponentUtil.getTextField("",this,{
            "x":85,
            "y":14,
            "color":11523767,
            "size":12,
            "leading":4
         });
         this._hadXiaoFeiTF = ComponentUtil.getTextField("",this,{
            "x":85,
            "y":32,
            "color":11523767,
            "size":12,
            "leading":4
         });
         this._xianGouTF = ComponentUtil.getTextField("",this,{
            "x":85,
            "y":55,
            "color":11523767,
            "size":12,
            "leading":4
         });
         this._button = ComponentUtil.getButton("","Button_TwoBule91",this,{
            "x":84,
            "y":81,
            "textColor":16771436
         },Global.Img_Cdm);
         this._button.callBack = this.clickButton;
         ComponentUtil.getBitmap("Text_TGRS",this,{
            "x":204,
            "y":10
         },Global.XFTGdm);
         this._curKuaFuTF = ComponentUtil.getTextField("",this,{
            "x":346,
            "y":10,
            "color":16383744,
            "size":16,
            "leading":0
         });
         ComponentUtil.getTextField("团购奖励每日0点通过邮件发送",this,{
            "x":418,
            "y":11,
            "color":575006,
            "size":12,
            "leading":0
         });
         this._gridVec = new Vector.<View_Grid>(6);
         this._numTFArr = [];
         this._gridCon = new Sprite();
         addChild(this._gridCon);
         this._gridCon.x = 195;
         this._gridCon.y = 42;
         ComponentUtil.getBitmap("Back_GQQD",this._gridCon,{
            "x":49,
            "y":20
         },Global.XFTGdm);
         ComponentUtil.getBitmap("Back_GQQD",this._gridCon,{
            "x":117,
            "y":20
         },Global.XFTGdm);
         ComponentUtil.getBitmap("Back_GQQD",this._gridCon,{
            "x":185,
            "y":20
         },Global.XFTGdm);
         ComponentUtil.getBitmap("Back_GQQD",this._gridCon,{
            "x":253,
            "y":20
         },Global.XFTGdm);
         ComponentUtil.getBitmap("Back_GQQD",this._gridCon,{
            "x":321,
            "y":20
         },Global.XFTGdm);
         ComponentUtil.getBitmap("Back_GQQ",this._gridCon,{
            "x":46,
            "y":22
         },Global.XFTGdm);
         ComponentUtil.getBitmap("Back_GQQ",this._gridCon,{
            "x":114,
            "y":22
         },Global.XFTGdm);
         ComponentUtil.getBitmap("Back_GQQ",this._gridCon,{
            "x":182,
            "y":22
         },Global.XFTGdm);
         ComponentUtil.getBitmap("Back_GQQ",this._gridCon,{
            "x":250,
            "y":22
         },Global.XFTGdm);
         ComponentUtil.getBitmap("Back_GQQ",this._gridCon,{
            "x":318,
            "y":22
         },Global.XFTGdm);
         i = 0;
         while(i < this._gridVec.length)
         {
            ComponentUtil.getBitmap("Back_GQD",this._gridCon,{
               "x":68 * i,
               "y":0
            },Global.XFTGdm);
            ComponentUtil.getBitmap("Back_GQ",this._gridCon,{
               "x":68 * i + 3,
               "y":3
            },Global.XFTGdm);
            tempGrid = new View_Grid();
            this._gridCon.addChild(tempGrid);
            this._gridVec[i] = tempGrid;
            tempGrid.set_bmp_bg();
            tempGrid.set_bmp_over();
            tempGrid.set_tf_count(true,false,true);
            tempGrid.x = 8 + i * 68;
            tempGrid.y = 8;
            tf = ComponentUtil.getTextField("",this._gridCon,{
               "x":i * 68 - 9,
               "y":50,
               "color":16184781,
               "size":12,
               "leading":0,
               "realWidth":68
            });
            tf.align = TextFormatAlign.CENTER;
            this._numTFArr.push(tf);
            bm = ComponentUtil.getBitmap("Icon_Suo",this._gridCon,{
               "x":15 + i * 68,
               "y":12
            },Global.XFTGdm);
            this._bmArr.push(bm);
            bm.visible = false;
            i++;
         }
         this.drawLine();
      }
      
      public function get grid() : View_Grid
      {
         return this._grid;
      }
      
      private function drawLine() : void
      {
         this._line = new Shape();
         this._line.graphics.lineStyle(2,16711680);
         this._line.graphics.moveTo(0,9);
         this._line.graphics.lineTo(85,9);
         addChild(this._line);
         this._line.x = 85;
         this._line.y = 14;
      }
      
      private function clickButton(e:MouseEvent) : void
      {
         var okFunc:Function;
         var str:String = null;
         if(!this._vo)
         {
            return;
         }
         TuanGouVo.BTN_INDEX = this._vo.id;
         if(this._vo.type != 5)
         {
            XiaoFeiTuanGouCGMessage.CG_XFTG_GETAWARD(this._vo.id);
         }
         else
         {
            okFunc = function():void
            {
               XiaoFeiTuanGouCGMessage.CG_XFTG_BUY(_vo.id);
            };
            if(this._vo.yuanbao >= this._upLineNum)
            {
               UIManager.centerBroadcast.addMsg("购买次数已达上限",1);
            }
            else
            {
               str = "<font color=\'#ffffff\'>确定花费<font color=\'#ffff00\'>" + this._xianjia + "元宝</font>购买" + this._grid.vo.str_name + "?</font>";
               if(!this._isShowTip)
               {
                  View_Alert.show(str,View_Alert.OK_CANCAL,okFunc,null,null,null,310,"","",TextFormatAlign.LEFT,true);
                  View_Alert.instance.showCheckBox = this.selectCheckBox;
               }
               else
               {
                  okFunc();
               }
            }
         }
      }
      
      private function selectCheckBox(box:CheckBox) : void
      {
         this._isShowTip = box.selected;
      }
      
      public function update(vo:TuanGouVo) : void
      {
         var arr:Array = null;
         var tempArr:Array = null;
         var tempItemArr:Array = null;
         var type:int = 0;
         var id:int = 0;
         var count:int = 0;
         var voI:Vo_item = null;
         var voE:Vo_equip = null;
         this._vo = vo;
         arr = Data_lib.xiaofeituangou[this._vo.id];
         this._xiaoFeiTF.htmlText = this.typeArr[this._vo.type - 1] + ": <font color=\'#F9FF00\'>" + arr[1] + "元宝</font>";
         if(this._vo.type != 5)
         {
            if(this._vo.type == 1)
            {
               if(this._vo.yuanbao >= arr[1])
               {
                  this._hadXiaoFeiTF.htmlText = this.hadTypeArr[0] + ": <font color=\'#F9FF00\'>≥" + arr[1] + "</font>";
               }
               else
               {
                  this._hadXiaoFeiTF.htmlText = this.hadTypeArr[0] + ": <font color=\'#F9FF00\'>" + this._vo.yuanbao + "</font>";
               }
            }
            else if(this._vo.yuanbao >= arr[1])
            {
               this._hadXiaoFeiTF.htmlText = this.hadTypeArr[1] + ": <font color=\'#F9FF00\'>≥" + arr[1] + "</font>";
            }
            else
            {
               this._hadXiaoFeiTF.htmlText = this.hadTypeArr[1] + ": <font color=\'#F9FF00\'>" + this._vo.yuanbao + "</font>";
            }
            this._xianGouTF.visible = false;
            this._button.label = "领取";
            this._line.visible = false;
         }
         else
         {
            this._xianGouTF.visible = true;
            tempArr = arr[1].toString().split("_");
            this._xiaoFeiTF.htmlText = this.typeArr[this._vo.type - 1] + ": <font color=\'#F9FF00\'>" + tempArr[0] + "元宝</font>";
            this._hadXiaoFeiTF.htmlText = this.hadTypeArr[2] + ": <font color=\'#F9FF00\'>" + tempArr[1] + "元宝</font>";
            this._xianjia = int(tempArr[1]);
            this._xianGouTF.htmlText = "今日限购: <font color=\'#F9FF00\'>" + this._vo.yuanbao + "/" + tempArr[2] + "</font>";
            this._upLineNum = int(tempArr[2]);
            this._button.label = "购买";
            this._line.visible = true;
         }
         this.updateBtnStatus();
         this.updateAwardGrid(arr[2]);
         var numArr:Array = arr[3].toString().split("_");
         var itemArr:Array = this.getItemIds(arr[4].toString());
         var i:int = 0;
         while(i < itemArr.length)
         {
            tempItemArr = itemArr[i];
            type = int(tempItemArr[0]);
            id = int(tempItemArr[1]);
            count = int(tempItemArr[2]);
            if(type == 1)
            {
               voI = new Vo_item();
               voI.id = id;
               voI.count = count;
               voI.Init_lib();
               this._gridVec[i].vo = voI;
            }
            else if(type == 2)
            {
               voE = new Vo_equip();
               voE.id = id;
               voE.count = count;
               voE.Init_lib();
               this._gridVec[i].vo = voE;
            }
            this._numTFArr[i].text = numArr[i] + "人";
            i++;
         }
      }
      
      public function updateTuanGou(num:int) : void
      {
         this._kuaFuNum = num;
         var numArr:Array = Data_lib.xiaofeituangou[this._vo.id][3].toString().split("_");
         var i:int = 0;
         while(i < numArr.length)
         {
            if(num < numArr[i])
            {
               this._gridVec[i].filters = Util.disabled;
               this._bmArr[i].visible = true;
            }
            else
            {
               this._gridVec[i].filters = null;
               this._bmArr[i].visible = false;
            }
            i++;
         }
         if(Boolean(this._curKuaFuTF))
         {
            this._curKuaFuTF.text = num.toString();
         }
      }
      
      private function updateAwardGrid(item:String) : void
      {
         var voI:Vo_item = null;
         var voE:Vo_equip = null;
         var arr:Array = item.split("_");
         var type:int = int(arr[0]);
         var id:int = int(arr[1]);
         var count:int = int(arr[2]);
         if(type == 1)
         {
            voI = new Vo_item();
            voI.id = id;
            voI.count = count;
            voI.Init_lib();
            this._grid.vo = voI;
         }
         else if(type == 2)
         {
            voE = new Vo_equip();
            voE.id = id;
            voE.count = count;
            voE.Init_lib();
            this._grid.vo = voE;
         }
      }
      
      public function getAward() : void
      {
         if(!this._vo)
         {
            return;
         }
         if(this._vo.type != 5)
         {
            this._vo.status = 3;
            this.updateBtnStatus();
         }
         else
         {
            ++this._vo.yuanbao;
            this._xianGouTF.htmlText = "今日限购: <font color=\'#F9FF00\'>" + this._vo.yuanbao + "/" + this._upLineNum + "</font>";
            if(this._vo.yuanbao >= this._upLineNum)
            {
               this._vo.status = 3;
               this._button.enabled = false;
            }
         }
         this.flyIcon();
      }
      
      private function flyIcon() : void
      {
         var p:Point = this.localToGlobal(new Point(this._grid.x,this._grid.y));
         ComboTweenStep.toBag(this._grid.vo,p.x + 17,p.y + 17);
      }
      
      private function updateBtnStatus() : void
      {
         if(!this._vo)
         {
            return;
         }
         switch(this._vo.status)
         {
            case 1:
               this._button.enabled = false;
               break;
            case 2:
               this._button.enabled = true;
               break;
            case 3:
               this._button.enabled = false;
               if(this._vo.type != 5)
               {
                  this._button.label = "已领取";
               }
         }
      }
      
      private function getItemIds(itemStr:String) : Array
      {
         var temp:Array = null;
         var itemArr:Array = itemStr.split(",");
         var idArr:Array = [];
         var i:int = 0;
         while(i < itemArr.length)
         {
            temp = this.getSingleId(itemArr[i]);
            idArr.push(temp);
            i++;
         }
         return idArr;
      }
      
      public function close(type:int) : void
      {
         if(type == 1)
         {
            this._button.enabled = false;
         }
         else
         {
            this._button.enabled = true;
         }
      }
      
      private function getSingleId(str:String) : Array
      {
         return str.split("_");
      }
   }
}

