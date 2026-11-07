package com.yiTian.view.modules.playerExtend
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScrollBar;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.modules.chat.ChatList;
   import com.yiTian.view.modules.paihang.PaiHangVO;
   import flash.display.Sprite;
   
   public class CGXTestPan extends Sprite
   {
      
      private static var _instance:CGXTestPan;
      
      public static var objData:Object;
      
      private var tf:MyTextField;
      
      private var contner:ChatList;
      
      private var dataSArr:Array = ["蓝(","年蓝(","黄(","年黄(","会(","年会(","豪(","年豪("];
      
      public function CGXTestPan()
      {
         var _spri:Sprite = null;
         super();
         GameScene.uiLayer.addChild(this);
         visible = false;
         var spri:Sprite = new Sprite();
         spri.graphics.beginFill(10066329,1);
         spri.graphics.drawRect(0,0,560,555);
         spri.graphics.endFill();
         addChild(spri);
         _spri = new Sprite();
         _spri.graphics.beginFill(1,1);
         _spri.graphics.drawRect(0,0,520,515);
         _spri.graphics.endFill();
         _spri.x = 20;
         _spri.y = 20;
         addChild(_spri);
         this.contner = new ChatList(520,515,ScrollBar.RIGHT,506);
         this.contner.x = 20;
         this.contner.y = 20;
         addChild(this.contner);
         var tt:MyTextField = ComponentUtil.getTextField("如果您打开了这个面板，请按CTRL+ALT+H关闭,平台参数：pf=" + Global.pf + "抽奖时间参数:",this,{
            "x":21,
            "y":1
         });
      }
      
      public static function get instance() : CGXTestPan
      {
         if(!_instance)
         {
            _instance = new CGXTestPan();
         }
         return _instance;
      }
      
      public static function set _objData(_data:Object) : void
      {
         objData = _data;
         if(Boolean(_instance) && _instance.visible)
         {
            _instance.updata();
         }
      }
      
      public function updata() : void
      {
         var _arr:Array = null;
         var i:int = 0;
         var _itemData:Object = null;
         var _imDArr:Array = null;
         var ss:String = null;
         var _typeLen:int = 0;
         var __len:int = 0;
         var _ttobj:Object = null;
         var j:int = 0;
         var _objItem:Object = null;
         var _ddss:String = null;
         var _friArr:Array = null;
         var f_i:int = 0;
         var friObj:Object = null;
         var fDataArr:Array = null;
         var fdLen:int = 0;
         var fd_gap_len:int = 0;
         var fd_str:String = null;
         var fd_i:int = 0;
         var objItem:Object = null;
         var ssLen:int = 0;
         var ssFri:String = null;
         this.contner.dispose();
         if(!visible)
         {
            visible = true;
         }
         if(objData is PaiHangVO)
         {
            _arr = (objData as PaiHangVO).paiHangItemArr;
            if(Boolean(_arr) && Boolean(_arr.length))
            {
               i = 0;
               while(i < _arr.length)
               {
                  _itemData = _arr[i];
                  if(_itemData is Array)
                  {
                     _imDArr = _itemData as Array;
                     if(Boolean(_imDArr) && Boolean(_imDArr.length))
                     {
                        ss = "";
                        __len = int(_imDArr.length);
                        _ttobj = _imDArr[__len - 1];
                        if(_ttobj is Array)
                        {
                           _typeLen = 9;
                        }
                        else
                        {
                           _typeLen = 8;
                        }
                        j = 0;
                        while(j < __len)
                        {
                           _objItem = _imDArr[j];
                           if(_objItem is Array)
                           {
                              if(j == __len - 1)
                              {
                                 ss += "[结婚信息]";
                              }
                              else
                              {
                                 ss += "[装备信息]" + "_";
                              }
                           }
                           else
                           {
                              _ddss = this.handld(_typeLen,j,__len,_objItem.toString());
                              ss += _ddss;
                           }
                           j++;
                        }
                        this.contner.addItem(ss,-1);
                     }
                  }
                  i++;
               }
            }
         }
         else if(objData is FriendCheckVo)
         {
            _friArr = (objData as FriendCheckVo)._dataArr;
            if(Boolean(_friArr) && Boolean(_friArr.length))
            {
               f_i = 0;
               while(f_i < _friArr.length)
               {
                  friObj = _friArr[f_i];
                  if(friObj is Array)
                  {
                     fDataArr = friObj as Array;
                     fdLen = int(fDataArr.length);
                     fd_gap_len = fdLen - 8;
                     fd_str = "个人信息:";
                     fd_i = 0;
                     while(fd_i < fdLen)
                     {
                        objItem = fDataArr[fd_i];
                        if(fd_i < fd_gap_len)
                        {
                           fd_str += objItem + "_";
                        }
                        else
                        {
                           ssLen = fd_i - fd_gap_len;
                           ssFri = this.dataSArr[ssLen] + objItem.toString() + ")_";
                           fd_str += ssFri;
                        }
                        fd_i++;
                     }
                     this.contner.addItem(fd_str,-1);
                  }
                  f_i++;
               }
            }
         }
      }
      
      private function handld(_typeL:int, _index:int, ArrLen:int, itemSS:String) : String
      {
         var _xx:int = _index - (ArrLen - _typeL);
         if(_xx >= 0)
         {
            return this.dataSArr[_xx] + itemSS + ")_";
         }
         return itemSS + "_";
      }
      
      public function hide() : void
      {
         visible = false;
      }
   }
}

