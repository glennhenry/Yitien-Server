package com.yiTian.view.modules.jiaoyi
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.model.Model_trans;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.JiaoYiCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   
   public class View_trans_check extends Panel
   {
      
      private var Button_OK:Button;
      
      private var Button_Cancel:Button;
      
      private var ZhuTiName_text:MyTextField;
      
      private var Button_Cancel_special:Button;
      
      private var JiaoYiRenName_text:MyTextField;
      
      private var WoiFangJinYuan_text:MyTextField;
      
      private var WoiFangYinYuan_text:MyTextField;
      
      private var DuiFangJinYuan_text:MyTextField;
      
      private var DuiFangYinYuan_text:MyTextField;
      
      private var self_grid:View_Grid;
      
      private var self_grids_arr:Array = [];
      
      private var other_grid:View_Grid;
      
      private var other_grid_arr:Array = [];
      
      private var trans_id:Number;
      
      private var _type:int;
      
      private var isFirstOpen:Boolean = true;
      
      public function View_trans_check()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var back:DisplayObject = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":328,
            "height":440
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":280,
            "height":390
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":97,
            "y":50,
            "width":100,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":97,
            "y":78,
            "width":100,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":34,
            "y":108,
            "width":260,
            "height":115
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":69,
            "y":190,
            "width":90,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":35,
            "y":110,
            "width":258,
            "height":26
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":194,
            "y":190,
            "width":90,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":34,
            "y":225,
            "width":260,
            "height":115
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":35,
            "y":226,
            "width":258,
            "height":26
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":69,
            "y":305,
            "width":90,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":194,
            "y":305,
            "width":90,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("YinLiang",this,{
            "x":170,
            "y":192
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("YinLiang",this,{
            "x":170,
            "y":307
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("YuanBao",this,{
            "x":45,
            "y":192
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("YuanBao",this,{
            "x":45,
            "y":307
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60142",6),this,{
            "x":40,
            "y":50,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60143",6),this,{
            "x":40,
            "y":80,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60144",6),this,{
            "x":130,
            "y":229,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60145",6),this,{
            "x":130,
            "y":113,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60146",6) + "\n" + LangConfig.getWord("60147",6),this,{
            "x":46,
            "y":380,
            "color":11904647,
            "size":12,
            "leading":5
         });
         move = new Rectangle(0,0,back.width,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":294,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_OK = ComponentUtil.getButton(LangConfig.getWord("61",0),"Button_Four",this,{
            "x":60.05 + 20,
            "y":350
         },Global.Img_Cdm);
         this.Button_Cancel = ComponentUtil.getButton(LangConfig.getWord("62",0),"Button_Four",this,{
            "x":155.95 + 20,
            "y":350
         },Global.Img_Cdm);
         this.Button_OK.visible = false;
         this.Button_Cancel.visible = false;
         this.Button_OK.callBack = this.sureHandle;
         this.Button_Cancel.callBack = this.cancel_handle;
         this.ZhuTiName_text = ComponentUtil.getTextField(LangConfig.getWord("63",0),this,{
            "x":86.45 + 15,
            "y":52,
            "color":16773818
         });
         this.JiaoYiRenName_text = ComponentUtil.getTextField(LangConfig.getWord("64",0),this,{
            "x":86.45 + 15,
            "y":77,
            "color":16773818
         });
         this.Button_Cancel_special = ComponentUtil.getButton(LangConfig.getWord("62",0),"Button_Four",this,{
            "x":123,
            "y":350,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Cancel_special.visible = false;
         this.Button_Cancel_special.callBack = this.cancelHandle;
         this.WoiFangJinYuan_text = ComponentUtil.getTextField("999,999,999",this,{
            "x":46.7 + 25,
            "y":307,
            "width":80,
            "realWidth":80,
            "color":14013822
         });
         this.WoiFangYinYuan_text = ComponentUtil.getTextField("999,999,999",this,{
            "x":169.9 + 25,
            "y":307,
            "width":80,
            "realWidth":80,
            "color":14013822
         });
         this.DuiFangJinYuan_text = ComponentUtil.getTextField("999,999,999",this,{
            "x":46.7 + 25,
            "y":194,
            "color":14013822
         });
         this.DuiFangYinYuan_text = ComponentUtil.getTextField("999,999,999",this,{
            "x":169.9 + 25,
            "y":194,
            "color":14013822
         });
         this.WoiFangJinYuan_text.restrict = ".0-9";
         this.DuiFangYinYuan_text.restrict = ".0-9";
         var i:int = 0;
         while(i < 5)
         {
            this.self_grid = new View_Grid();
            this.self_grid.index = i + 1;
            this.self_grid.set_bmp_bg();
            this.self_grid.set_bmp_over(true,null);
            this.self_grid.set_bmp_select();
            this.self_grid.isAutoLoad = false;
            this.self_grid.set_tf_count();
            this.self_grid.x = 47 + i * 49.25;
            this.self_grid.y = 260;
            this.self_grid.type = Enum_type_grid.JIAOYI;
            addChild(this.self_grid);
            this.self_grid.doubleClickEnabled = true;
            this.self_grid.addEventListener(MouseEvent.DOUBLE_CLICK,this.double_click_handle);
            this.self_grid.addEventListener(MouseEvent.MOUSE_UP,this.upHandle);
            this.self_grids_arr.push(this.self_grid);
            i++;
         }
         var j:int = 0;
         while(j < 5)
         {
            this.other_grid = new View_Grid();
            this.other_grid.index = j + 1;
            this.other_grid.set_bmp_bg();
            this.other_grid.set_bmp_over(true,null);
            this.other_grid.set_bmp_select();
            this.other_grid.set_tf_count();
            this.other_grid.isAutoLoad = false;
            this.other_grid.x = 47 + j * 49.25;
            this.other_grid.y = 144;
            this.other_grid.type = Enum_type_grid.JIAOYI;
            addChild(this.other_grid);
            this.other_grid_arr.push(this.other_grid);
            j++;
         }
      }
      
      private function cancel_handle(e:MouseEvent) : void
      {
         if(this._type == 2)
         {
            JiaoYiCGMessage.CG_JIAOYI_RETURN(this.trans_id,2,this.JiaoYiRenName_text.text);
         }
         else if(this._type == 3)
         {
            JiaoYiCGMessage.CG_JIAOYI_RETURN(this.trans_id,3,this.JiaoYiRenName_text.text);
         }
         else if(this._type == 5)
         {
            JiaoYiCGMessage.CG_JIAOYI_RETURN(this.trans_id,4,this.JiaoYiRenName_text.text);
         }
      }
      
      public function update(jy_id:Number, items_self_arr:Array, equips_self_arr:Array, _items_other_arr:Array, _equips_other_arr:Array, role_YB:int, role_YL:int, otherRole_YB:int, otherRole_YL:int) : void
      {
         this.reset_handle();
         this.get_name_title();
         this.handle_type();
         this.Operation_type();
         this.trans_id = jy_id;
         this.init_self_handle(items_self_arr,equips_self_arr,role_YB,role_YL);
         this.init_other_handle(_items_other_arr,_equips_other_arr,otherRole_YB,otherRole_YL);
      }
      
      private function get_name_title() : void
      {
         this.ZhuTiName_text.text = Model_trans.check_trans_title;
         var _name:String = Model_trans.check_trans_name;
         _name = Model_heFu.repNameByHero(_name);
         this.JiaoYiRenName_text.text = _name;
      }
      
      private function sureHandle(e:MouseEvent) : void
      {
         var tem_btn:Button = e.target as Button;
         if(tem_btn.label == LangConfig.getWord("65",0))
         {
            this.Reply_handle();
         }
         else if(tem_btn.label == LangConfig.getWord("61",0))
         {
            this.Confirmation_handle();
         }
      }
      
      private function Confirmation_handle() : void
      {
         JiaoYiCGMessage.CG_JIAOYI_RETURN(this.trans_id,5,this.JiaoYiRenName_text.text);
      }
      
      private function cancelHandle(e:MouseEvent) : void
      {
         var tem_type:int = 0;
         if(this._type == 1)
         {
            tem_type = 1;
         }
         else if(this._type == 2)
         {
            tem_type = 2;
         }
         else if(this._type == 6)
         {
            tem_type = 3;
         }
         else if(this._type == 5)
         {
            tem_type = 4;
         }
         JiaoYiCGMessage.CG_JIAOYI_RETURN(this.trans_id,tem_type,this.JiaoYiRenName_text.text);
      }
      
      private function Reply_handle() : void
      {
         var bag_grid_arr:Array = [];
         var tem_num_arr:Array = [];
         var trans_grid_arr:Array = [];
         var i:int = 0;
         while(i < this.self_grids_arr.length)
         {
            if(Boolean(this.self_grids_arr[i].vo))
            {
               bag_grid_arr.push(this.self_grids_arr[i].vo.gridId);
               tem_num_arr.push(this.self_grids_arr[i].count == 0 ? 1 : this.self_grids_arr[i].count);
               trans_grid_arr.push(i + 1);
            }
            i++;
         }
         var temStr_JY:String = this.WoiFangJinYuan_text.text.replace(/,/gi,"");
         var temStr_YY:String = this.WoiFangYinYuan_text.text.replace(/,/gi,"");
         if(int(temStr_JY) > GameUnitManager.hero.money || int(temStr_YY) > GameUnitManager.hero.silver)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("66",0));
            return;
         }
         Model_trans.txt_remov_handle(this.WoiFangJinYuan_text);
         Model_trans.txt_remov_handle(this.WoiFangYinYuan_text);
         JiaoYiCGMessage.CG_JIAOYI_REP(this.JiaoYiRenName_text.text,this.trans_id,int(this.WoiFangYinYuan_text.text),int(this.WoiFangJinYuan_text.text),bag_grid_arr,tem_num_arr,trans_grid_arr);
      }
      
      private function handle_type() : void
      {
         this._type = Model_trans.check_type;
         switch(this._type)
         {
            case 1:
               this.Button_Cancel_special.visible = true;
               break;
            case 2:
               this.Button_OK.visible = true;
               this.Button_OK.label = LangConfig.getWord("65",0);
               this.Button_Cancel.visible = true;
               break;
            case 3:
               this.Button_OK.visible = false;
               this.Button_Cancel_special.visible = false;
               this.Button_Cancel.visible = false;
               break;
            case 4:
               this.Button_OK.visible = false;
               this.Button_Cancel_special.visible = false;
               this.Button_Cancel.visible = false;
               break;
            case 5:
               this.Button_Cancel.visible = true;
               this.Button_OK.visible = true;
               this.Button_OK.label = LangConfig.getWord("61",0);
               break;
            case 6:
               this.Button_Cancel_special.visible = true;
               break;
            case 7:
               this.Button_OK.visible = false;
               this.Button_Cancel_special.visible = false;
               this.Button_Cancel.visible = false;
         }
      }
      
      private function Operation_type() : void
      {
         if(this._type == 1)
         {
            this.WoiFangJinYuan_text.type = TextFieldType.DYNAMIC;
            this.WoiFangYinYuan_text.type = TextFieldType.DYNAMIC;
         }
         else if(this._type == 2)
         {
            this.WoiFangJinYuan_text.type = TextFieldType.INPUT;
            this.WoiFangYinYuan_text.type = TextFieldType.INPUT;
            this.WoiFangJinYuan_text.addEventListener(Event.CHANGE,this.JYHandle);
            this.WoiFangYinYuan_text.addEventListener(Event.CHANGE,this.YYHandle);
         }
      }
      
      private function JYHandle(e:Event) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         Model_trans.txt_ch_handle(tf,GameUnitManager.hero.money);
      }
      
      private function YYHandle(e:Event) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         Model_trans.txt_ch_handle(tf,GameUnitManager.hero.silver);
      }
      
      public function operation(_grid:View_Grid) : void
      {
         if(this._type == 1)
         {
            return;
         }
         if(this._type == 2)
         {
            this.add_JY_goods(_grid);
         }
      }
      
      private function double_click_handle(e:MouseEvent) : void
      {
         var tem_grid:View_Grid = e.target as View_Grid;
         if(this._type == 2 && Boolean(tem_grid.vo))
         {
            this.back_to_bag(tem_grid);
            tem_grid.vo = null;
            return;
         }
      }
      
      private function back_to_bag(_grid:View_Grid) : void
      {
         UIManager.bagPanel.set_mask(_grid.vo.gridId,false);
      }
      
      private function add_JY_goods(_grid:View_Grid) : void
      {
         var tem_num:int = this.get_empty_grid(5);
         if(Boolean(_grid) && Boolean(_grid.vo))
         {
            if(_grid.vo is Vo_equip && (_grid.vo as Vo_equip).type == 12)
            {
               UIManager.centerBroadcast.addMsg("勋章不能交易");
               return;
            }
         }
         if(tem_num == -1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("67",0));
         }
         else
         {
            if((_grid.vo as Vo_valuable).bBind)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("68",0));
               return;
            }
            if(_grid.vo.count > 1)
            {
               UIManager.trans_num.visible = true;
               UIManager.trans_num.update(_grid,-1,"check");
               return;
            }
            this.self_grids_arr[tem_num].vo = _grid.vo;
            UIManager.bagPanel.set_mask(_grid.vo.gridId,true);
         }
      }
      
      private function getGrid(disp:DisplayObject) : View_Grid
      {
         if(disp is View_Grid)
         {
            return disp as View_Grid;
         }
         return this.getGrid(disp.parent);
      }
      
      private function upHandle(e:MouseEvent) : void
      {
         var upGrid:View_Grid = null;
         var dragGrid:View_Grid = null;
         var temp:Vo_valuable = null;
         if(this._type == 2)
         {
            upGrid = this.getGrid(e.target as DisplayObject);
            if(UIManager.isDrag)
            {
               dragGrid = UIManager.dragObj.grid;
               if(dragGrid.type == Enum_type_grid.BAG)
               {
                  if(dragGrid.vo is Vo_valuable)
                  {
                     temp = dragGrid.vo as Vo_valuable;
                  }
                  if(temp.bBind)
                  {
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("68",0));
                     return;
                  }
                  this.update_grid_vo(dragGrid,upGrid);
               }
            }
            return;
         }
      }
      
      private function update_grid_vo(_grid:View_Grid, _up_grid:View_Grid) : void
      {
         var temN:int = this.get_empty_grid(5);
         if(temN == -1)
         {
            if(_grid.vo.count > 1)
            {
               UIManager.trans_num.visible = true;
               UIManager.trans_num.update(_grid,_up_grid.index,"check");
               return;
            }
            this.update_grid(_grid,_up_grid);
         }
         else
         {
            if(_grid.vo.count > 1)
            {
               UIManager.trans_num.visible = true;
               UIManager.trans_num.update(_grid,-1,"check");
               return;
            }
            this.self_grids_arr[temN].vo = _grid.vo;
            this.update_grid(_grid);
         }
      }
      
      private function update_grid(now_grid:View_Grid, pre_grid:View_Grid = null) : void
      {
         if(Boolean(pre_grid))
         {
            if(Boolean(pre_grid.vo))
            {
               UIManager.bagPanel.set_mask(pre_grid.vo.gridId,false);
               pre_grid.vo = now_grid.vo;
            }
         }
         UIManager.bagPanel.set_mask(now_grid.vo.gridId,true);
      }
      
      private function get_empty_grid(max_num:int) : int
      {
         var i:int = 0;
         while(i < max_num)
         {
            if(this.self_grids_arr[i].vo == null)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      public function update_num(_vo:Vo_grid, _count:int, _index:int = -1) : void
      {
         var tem_num:int = 0;
         if(_index != -1)
         {
            UIManager.bagPanel.set_mask(this.self_grids_arr[_index - 1].vo.gridId,false);
            this.self_grids_arr[_index - 1].vo = _vo;
            this.self_grids_arr[_index - 1].count = _count;
            UIManager.bagPanel.set_mask(_vo.gridId,true);
         }
         else
         {
            tem_num = this.get_empty_grid(5);
            if(tem_num == -1)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("67",0));
            }
            else
            {
               this.self_grids_arr[tem_num].vo = _vo;
               this.self_grids_arr[tem_num].count = _count;
               UIManager.bagPanel.set_mask(_vo.gridId,true);
            }
         }
      }
      
      private function reset_handle() : void
      {
         this.trans_id = 0;
         var i:int = 0;
         while(i < 5)
         {
            this.self_grids_arr[i].vo = null;
            this.other_grid_arr[i].vo = null;
            i++;
         }
         this.Button_OK.visible = false;
         this.Button_Cancel_special.visible = false;
         this.Button_Cancel.visible = false;
         this.WoiFangJinYuan_text.type = TextFieldType.DYNAMIC;
         this.WoiFangYinYuan_text.type = TextFieldType.DYNAMIC;
         this.WoiFangJinYuan_text.text = "";
         this.WoiFangYinYuan_text.text = "";
      }
      
      private function init_self_handle(items_arr:Array, equips_arr:Array, role_YB:int, role_YL:int) : void
      {
         this.WoiFangJinYuan_text.text = Utils.getGapNum(String(role_YB));
         this.WoiFangYinYuan_text.text = Utils.getGapNum(String(role_YL));
         this.self_init_item(items_arr);
         this.self_init_equip(equips_arr);
      }
      
      private function self_init_item(items_arr:Array) : void
      {
         var tem_item:Vo_item = null;
         if(!items_arr.length)
         {
            return;
         }
         var i:int = 0;
         while(i < items_arr.length)
         {
            tem_item = new Vo_item();
            tem_item.id = items_arr[i][0];
            tem_item.Init_lib();
            this.self_grids_arr[items_arr[i][3] - 1].vo = tem_item;
            this.self_grids_arr[items_arr[i][3] - 1].count = items_arr[i][1];
            i++;
         }
      }
      
      private function self_init_equip(equips_arr:Array) : void
      {
         var tem_equip:Vo_equip = null;
         if(!equips_arr.length)
         {
            return;
         }
         if(equips_arr[0] == null)
         {
            return;
         }
         var i:int = 0;
         while(i < equips_arr.length)
         {
            tem_equip = new Vo_equip();
            tem_equip.Init_sever_bag(equips_arr[i]);
            this.self_grids_arr[equips_arr[i][2] - 1].vo = tem_equip;
            i++;
         }
      }
      
      private function other_init_item(_items_other_arr:Array) : void
      {
         var tem_item:Vo_item = null;
         if(!_items_other_arr.length)
         {
            return;
         }
         var i:int = 0;
         while(i < _items_other_arr.length)
         {
            tem_item = new Vo_item();
            tem_item.id = _items_other_arr[i][0];
            tem_item.Init_lib();
            this.other_grid_arr[_items_other_arr[i][3] - 1].vo = tem_item;
            this.other_grid_arr[_items_other_arr[i][3] - 1].count = _items_other_arr[i][1];
            i++;
         }
      }
      
      private function otehr_init_equip(_equips_other_arr:Array) : void
      {
         var tem_equip:Vo_equip = null;
         if(!_equips_other_arr.length)
         {
            return;
         }
         if(_equips_other_arr[0] == null)
         {
            return;
         }
         var i:int = 0;
         while(i < _equips_other_arr.length)
         {
            tem_equip = new Vo_equip();
            tem_equip.Init_sever_bag(_equips_other_arr[i]);
            this.other_grid_arr[_equips_other_arr[i][2] - 1].vo = tem_equip;
            i++;
         }
      }
      
      private function init_other_handle(_items_other_arr:Array, _equips_other_arr:Array, otherRole_YB:int, otherRole_YL:int) : void
      {
         this.DuiFangJinYuan_text.text = Utils.getGapNum(String(otherRole_YB));
         this.DuiFangYinYuan_text.text = Utils.getGapNum(String(otherRole_YL));
         this.other_init_item(_items_other_arr);
         this.otehr_init_equip(_equips_other_arr);
      }
      
      public function reset_data_handle() : void
      {
         var tem_grid:View_Grid = null;
         var i:int = 0;
         while(i < this.self_grids_arr.length)
         {
            tem_grid = this.self_grids_arr[i];
            if(Boolean(tem_grid.vo))
            {
               UIManager.bagPanel.set_mask(tem_grid.vo.gridId,false);
               tem_grid.vo = null;
            }
            i++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!value)
         {
            if(this._type == 2)
            {
               this.reset_data_handle();
            }
         }
         else if(this.isFirstOpen)
         {
            this.setGridLoad();
            this.isFirstOpen = false;
            Utils.loadTitle("lang/ch/JiaoYi_Imgs.swf","Title_JiaoYi",new Bitmap(),{
               "x":84,
               "y":5
            },this);
         }
      }
      
      public function setGridLoad() : void
      {
         var i:int = 0;
         while(i < this.self_grids_arr.length)
         {
            this.self_grids_arr[i].isAutoLoad = true;
            this.self_grids_arr[i].beginLoad();
            i++;
         }
         i = 0;
         while(i < this.other_grid_arr.length)
         {
            this.other_grid_arr[i].isAutoLoad = true;
            this.other_grid_arr[i].beginLoad();
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

