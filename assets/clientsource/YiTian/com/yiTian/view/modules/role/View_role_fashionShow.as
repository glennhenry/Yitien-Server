package com.yiTian.view.modules.role
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.gameUnit.role.Hero;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.RoleCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.tianTi.Child_tianTiUnit;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class View_role_fashionShow extends View_role_base
   {
      
      public var lightMap:Object;
      
      private var _bgLayer:Sprite;
      
      private var _oldSelected:RoleFashionItem;
      
      private var _modelRole:Child_tianTiUnit;
      
      private var _fasionIDSet:Array;
      
      private var _itemMap:Object;
      
      private var _bg:DisplayObject;
      
      private var _items:Array = [];
      
      private var cont:ItemCont;
      
      private var _txtItem:ATBSP;
      
      private var _isFirstOpen:Boolean = true;
      
      public function View_role_fashionShow()
      {
         super();
      }
      
      public function set animateEnabled(v:Boolean) : void
      {
         if(!this._modelRole)
         {
            return;
         }
         if(v)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this._modelRole.onFrame);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this._modelRole.onFrame);
         }
      }
      
      public function updateBody() : void
      {
         var hero:Hero = GameUnitManager.hero;
         this._modelRole.sex = hero.sex;
         this._modelRole.job = hero.job;
         this._modelRole.modelId = hero.body;
         this._modelRole.weaponDir = hero.weapon.toString();
         this._modelRole.wing = hero.wing;
         if(Boolean(this._oldSelected))
         {
            this._oldSelected.selected = false;
         }
         this._modelRole.updateLayer();
      }
      
      public function updateLigth(map:Object) : void
      {
         var item:RoleFashionItem = null;
         this.lightMap = map;
         for each(item in this._items)
         {
            if(map[item.type] == true)
            {
               item.update(1);
            }
            else
            {
               item.update(0);
            }
         }
      }
      
      private function getFashionID(index:int) : String
      {
         var highType:int = 0;
         var lowType:int = 0;
         var type:int = 0;
         var temp:Array = null;
         var len:int = 0;
         var i:int = 0;
         var sex:int = 0;
         var job:int = 0;
         var lib:Array = Data_lib.sjszs.toArray();
         if(index > 40)
         {
            len = int(lib.length);
            i = 0;
            while(i < len)
            {
               if(lib[i][2] == index)
               {
                  temp = String(lib[i][7]).split("");
                  break;
               }
               i++;
            }
            sex = GameUnitManager.hero.sex;
            job = int(Enum_job.getBaseJob(GameUnitManager.hero.job));
            return "" + temp[0] + temp[1] + job + temp[3] + sex;
         }
         if(index > 30)
         {
            index += 30;
         }
         highType = index / 10;
         lowType = index % 10;
         type = highType * 1000 + lowType * 10;
         return (20000 + Enum_job.getBaseJob(GameUnitManager.hero.job) * 100 + type + GameUnitManager.hero.sex).toString();
      }
      
      public function updateAtb(v:Object) : void
      {
         var properityTypes:Array = [1,2,13];
         var str:String = "";
         var i:int = 0;
         while(i < properityTypes.length)
         {
            str += Data_lib.attribute[properityTypes[i]][0] + "+" + v[i] + "\n";
            i += 1;
         }
         this._txtItem.txt = str;
      }
      
      private function itemBtnClickHd(it:RoleFashionItem, e:MouseEvent) : void
      {
         if(e.target is Button)
         {
            if(it.data == 0)
            {
               RoleCGMessage.CG_LIGHT_FASHION(it.type);
            }
            else if(it.data == 1)
            {
               RoleCGMessage.CG_DRESS_FASHION(it.type);
            }
         }
         else
         {
            if(Boolean(this._oldSelected))
            {
               this._oldSelected.selected = false;
            }
            this._oldSelected = it;
            it.selected = true;
            this._modelRole.modelId = int(this.getFashionID(it.type));
         }
      }
      
      public function updateItems(v:Array) : void
      {
         var vo:Vo_equip = null;
         var item:RoleFashionItem = null;
         var i:int = 0;
         while(i < v.length)
         {
            vo = new Vo_equip();
            vo.id = v[i] as int;
            vo.Init_lib();
            item = this._items[i];
            item.updateGridVo(vo);
            item.type = Data_lib.sjszs[vo.id][1];
            item.fashionId = Data_lib.sjszs[vo.id][3];
            i += 1;
         }
         while(i < this._items.length)
         {
            item = this._items[i];
            item.update(-1);
            item.type = 0;
            i += 1;
         }
      }
      
      public function showGridAni(index:int) : void
      {
         var bm:Bitmap2 = null;
         var p1:Point = null;
         var p2:Point = null;
         var item:RoleFashionItem = this._items[index];
         var gird:View_Grid = item._grid;
         bm = new Bitmap2();
         bm.load("resource/image/icon60/" + gird.vo.str_icon + ".png");
         p1 = localToGlobal(new Point(this._modelRole.x,this._modelRole.y));
         p2 = gird.localToGlobal(new Point(20,20));
         bm.x = p1.x - 20;
         bm.y = p1.y - 100;
         GameScene.popupLayer.addChild(bm);
         Tween.curTo(bm,1000,{"y":bm.y - 150},function():void
         {
            Tween.curTo(bm,1000,{
               "x":p2.x,
               "y":p2.y
            },function():void
            {
               bm.load(null);
               bm.parent.removeChild(bm);
            },null,Tween.SIN);
         },null,Tween.SIN);
      }
      
      public function keyBoardTest() : void
      {
         var index:int = Math.random() * this._items.length;
         this.showGridAni(index);
      }
      
      private function init1() : void
      {
         var loc_it:RoleFashionItem = null;
         this._bgLayer = new Sprite();
         addChild(this._bgLayer);
         this._bg = ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this._bgLayer,{
            "x":29,
            "y":67,
            "width":416,
            "height":404
         },Global.Img_Cdm);
         this._modelRole = new Child_tianTiUnit();
         this._modelRole.type = Child_tianTiUnit.PLAYER;
         this._modelRole.x = 118;
         this._modelRole.y = 277;
         var _temp_1:* = this._modelRole;
         this._modelRole.scaleY = 1;
         _temp_1.scaleX = 1;
         this._modelRole.way = 4;
         addChild(this._modelRole);
         var hero:Hero = GameUnitManager.hero;
         this._modelRole.setFrameInterval(150);
         this._modelRole.updateLayer();
         ComponentUtil.getScaleBitmap("Back_Diamond02",[1,1,1,1],this,{
            "x":200,
            "y":73,
            "width":240,
            "height":377
         },Global.Img_Cdm);
         var tf:MyTextField = ComponentUtil.getTextField("",this,{
            "x":36,
            "y":75,
            "color":3407667,
            "multiline":true,
            "leading":2,
            "realWidth":155,
            "wordWrap":true
         });
         tf.htmlText = LangConfig.getWord("29449",2);
         this.cont = new ItemCont();
         this.cont.x = 205;
         this.cont.y = 77;
         this._fasionIDSet = this.getIDSet(GameUnitManager.hero.sex);
         var i:int = 0;
         while(i < this._fasionIDSet.length)
         {
            loc_it = new RoleFashionItem();
            this.cont.insertItem(loc_it);
            this._items.push(loc_it);
            loc_it.setBtnClick(this.itemBtnClickHd);
            i += 1;
         }
         addChild(this.cont);
         this.updateItems(this._fasionIDSet);
         this._txtItem = new ATBSP();
         this._txtItem.x = 34;
         this._txtItem.y = 354;
         addChild(this._txtItem);
      }
      
      override public function Init() : void
      {
         this.init1();
      }
      
      override public function set visible(value:Boolean) : void
      {
         var it:RoleFashionItem = null;
         super.visible = value;
         if(value)
         {
            if(this._isFirstOpen)
            {
               Utils.loadTitle("lang/ch/Role_Imgs.swf","Back_ShiZhuang",new Bitmap(),{
                  "x":30,
                  "y":68
               },this._bgLayer);
               this._txtItem.beginLoad();
               for each(it in this._items)
               {
                  it.beginLoad();
               }
               this._isFirstOpen = false;
            }
            this.updateBody();
            this.cont.reset();
            if(Boolean(this._oldSelected))
            {
               this._oldSelected.selected = false;
               this._oldSelected = null;
            }
            RoleCGMessage.CG_ROLE_FASHION();
         }
         this.animateEnabled = value;
      }
      
      private function sorrt(a:int, b:int) : int
      {
         if(a > b)
         {
            return 1;
         }
         if(a < b)
         {
            return -1;
         }
         return 0;
      }
      
      private function getIDSet(sex:int) : Array
      {
         var a:Array = null;
         var len:int = 0;
         var i:int = 0;
         var itemSex:int = 0;
         var itemType:int = 0;
         var r:Array = [];
         var tmp:Object = {};
         var srcArr:Array = Data_lib.sjszs.toArray();
         for each(a in srcArr)
         {
            itemSex = int(a[1]);
            itemType = int(a[2]);
            if(!tmp[itemType] && itemSex == sex)
            {
               tmp[itemType] = true;
               r.push(a);
            }
         }
         r.sort(function(c:Array, d:Array):int
         {
            return c[2] - d[2];
         });
         len = int(r.length);
         i = 0;
         while(i < len)
         {
            r[i] = r[i][0];
            i += 1;
         }
         return r;
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.utils.Util;
import com.yiTian.Global;
import com.yiTian.data.Data_lib;
import com.yiTian.data.vo.Vo_equip;
import com.yiTian.manager.LangConfig;
import com.yiTian.utils.Tween;
import com.yiTian.utils.Utils;
import com.yiTian.view.comp.View_Grid;
import com.yiTian.view.modules.role.View_fashionPrompt;
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextFieldAutoSize;

class ItemCont extends Sprite
{
   
   private var cont:Sprite = new Sprite();
   
   private var _mask:DisplayObject;
   
   public var stepNumX:Number = 118;
   
   public var stepNumY:Number = 171;
   
   private var _pageTf:MyTextField;
   
   private var _MaxPage:int;
   
   private var _curpage:int;
   
   private var items:Vector.<DisplayObject> = new Vector.<DisplayObject>();
   
   public function ItemCont()
   {
      super();
      addChild(this.cont);
      this._mask = ComponentUtil.getShape(232,375,255,0.3);
      addChild(this._mask);
      mask = this._mask;
      ComponentUtil.getScaleBitmap("Text_Back",[6,6,4,4],this,{
         "x":86,
         "y":345,
         "width":60,
         "height":22
      },Global.Img_Cdm);
      ComponentUtil.getButton("","Button_PageLeft",this,{
         "x":62,
         "y":346,
         "callBack":this.leftClick
      },Global.Img_Cdm);
      ComponentUtil.getButton("","Button_PageRight",this,{
         "x":150,
         "y":346,
         "callBack":this.rightClick
      },Global.Img_Cdm);
      this._pageTf = ComponentUtil.getTextField("1/3",this,{
         "x":114,
         "y":347,
         "color":16184781
      });
      this._pageTf.autoSize = TextFieldAutoSize.CENTER;
   }
   
   public function insertItem(o:DisplayObject) : void
   {
      var yy:Number = NaN;
      var page:int = this._MaxPage = this.items.length / 4;
      var indexOnPage:int = this.items.length - page * 4;
      var xx:Number = (page * 2 + int(indexOnPage / 2)) * this.stepNumX;
      yy = int(indexOnPage % 2) * this.stepNumY;
      o.x = xx;
      o.y = yy;
      this.items.push(o);
      this.cont.addChild(o);
      this.updatePageTf();
   }
   
   private function leftClick(e:MouseEvent) : void
   {
      this._curpage = Math.max(this._curpage - 1,0);
      var pre:Number = -2 * this._curpage * this.stepNumX;
      Tween.curTo(this.cont,300,{"x":pre},null,null,Tween.SIN);
      this.updatePageTf();
   }
   
   private function rightClick(e:MouseEvent) : void
   {
      this._curpage = Math.min(this._curpage + 1,this._MaxPage);
      var nxt:Number = -2 * this._curpage * this.stepNumX;
      Tween.curTo(this.cont,300,{"x":nxt},null,null,Tween.SIN);
      this.updatePageTf();
   }
   
   private function updatePageTf() : void
   {
      this._pageTf.text = (this._curpage + 1).toString() + "/" + (this._MaxPage + 1).toString();
   }
   
   public function reset() : void
   {
      this.cont.y = 0;
   }
}

class RoleFashionItem extends Sprite
{
   
   public var type:int;
   
   public var data:int;
   
   public var fashionId:int;
   
   private var _tfBuySp:Sprite;
   
   private var _isNeedUpdate:Boolean = false;
   
   private var _bgLayer:Sprite = new Sprite();
   
   private var _btnClick:Function;
   
   public var _grid:View_Grid;
   
   private var _tfTitle:MyTextField;
   
   private var _tfAtb:MyTextField;
   
   private var _btn:Button;
   
   private var _isRollOver:Boolean;
   
   private var _selected:Boolean = false;
   
   public function RoleFashionItem()
   {
      super();
      addChild(this._bgLayer);
      this._tfAtb = ComponentUtil.getTextField("",this,{
         "x":21,
         "y":85,
         "color":16776960,
         "size":12
      });
      this._grid = new View_Grid(true);
      this._grid.x = 25;
      this._grid.y = 13;
      this._grid.isAutoLoad = false;
      this._grid.set_bmp_bg(null);
      addChild(this._grid);
      this._tfTitle = ComponentUtil.getTextField(LangConfig.getWord("29452",2),this,{
         "x":57,
         "y":62,
         "color":16777215
      });
      this._tfTitle.autoSize = TextFieldAutoSize.CENTER;
      this._tfBuySp = new Sprite();
      addChild(this._tfBuySp);
      this._tfBuySp.buttonMode = true;
      this._tfBuySp.visible = false;
      this._tfBuySp.addEventListener(MouseEvent.ROLL_OVER,this.spRI);
      this._tfBuySp.addEventListener(MouseEvent.ROLL_OUT,this.spRO);
      this._tfBuySp.addEventListener(MouseEvent.CLICK,this.spClickHd);
      this._btn = ComponentUtil.getButton("","Button_TwoBule91",this,{
         "x":11,
         "y":136,
         "textColor":16184781
      },Global.Img_Cdm);
      this._btn.enabled = false;
      addEventListener(MouseEvent.CLICK,this.onBtnClick);
   }
   
   public function update(v:int) : void
   {
      this.data = v;
      if(!this._btn)
      {
         this._isNeedUpdate = true;
         return;
      }
      if(!this._grid.vo)
      {
         this._btn.enabled = false;
      }
      else if(v == 0)
      {
         this._btn.enabled = true;
         this._grid.set_grey(true);
         this._btn.label = LangConfig.getWord("29450",2);
         this._tfBuySp.visible = true;
      }
      else if(v == 1)
      {
         this._btn.enabled = true;
         this._grid.set_grey(false);
         this._btn.label = LangConfig.getWord("29451",2);
         this._tfBuySp.visible = false;
      }
      else if(v == -1)
      {
         this._btn.enabled = false;
      }
   }
   
   public function beginLoad() : void
   {
      this._grid.beginLoad();
      Utils.loadTitle("lang/ch/Role_Imgs.swf","Back_Card",new Bitmap(),null,this._bgLayer);
      Utils.loadTitle("lang/ch/Role_Imgs.swf","Back_Name",new Bitmap(),{
         "x":23,
         "y":60
      }._bgLayer);
      Utils.loadTitle("lang/ch/Role_Imgs.swf","Text_GouMai",new Bitmap(),{
         "x":53,
         "y":8
      },this._tfBuySp);
   }
   
   public function updateGridVo(v:Vo_equip) : void
   {
      var tmp:String = null;
      var a:Array = null;
      this._grid.vo = v;
      this._tfTitle.text = v.str_name;
      var atbs:Array = Util.splicObj(Data_lib.sjszs[v.id][4] as String,",_") as Array;
      var txts:Array = [];
      var i:int = 0;
      while(i < atbs.length)
      {
         tmp = "";
         a = atbs[i];
         tmp = Data_lib.attribute[a[0]][0] + "+" + a[1];
         txts.push(tmp);
         i += 1;
      }
      this._tfAtb.text = txts.join("\n");
   }
   
   public function setBtnClick(func:Function) : void
   {
      this._btnClick = func;
   }
   
   private function onBtnClick(e:MouseEvent) : void
   {
      if(this._btnClick != null)
      {
         this._btnClick(this,e);
      }
   }
   
   private function spRI(e:MouseEvent) : void
   {
      (e.target as DisplayObject).transform.colorTransform = Util.colorWhite2;
   }
   
   private function spRO(e:MouseEvent) : void
   {
      (e.target as DisplayObject).transform.colorTransform = Util.colorNomal;
   }
   
   private function spClickHd(e:MouseEvent) : void
   {
      View_fashionPrompt.instance.show(this._grid.vo);
   }
   
   private function onRollOverHd(e:MouseEvent) : void
   {
      this._isRollOver = true;
   }
   
   private function onRollOutHd(e:MouseEvent) : void
   {
      this._isRollOver = false;
   }
   
   public function set selected(v:Boolean) : void
   {
      this._selected = v;
   }
}

class ATBSP extends Sprite
{
   
   private var _tfAtb:MyTextField;
   
   public function ATBSP()
   {
      super();
      ComponentUtil.getScaleBitmap("Back_Diamond02",[3,3,1,1],this,{
         "x":0,
         "y":0,
         "width":164,
         "height":96
      },Global.Img_Cdm);
      this._tfAtb = ComponentUtil.getTextField("",this,{
         "x":15,
         "y":37,
         "color":16772146,
         "leading":3
      });
   }
   
   public function set txt(v:String) : void
   {
      this._tfAtb.text = v;
   }
   
   public function beginLoad() : void
   {
      Utils.loadTitle("lang/ch/Role_Imgs.swf","Text_ZSX",new Bitmap(),null,this);
   }
}
