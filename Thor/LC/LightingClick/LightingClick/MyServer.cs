﻿using System;
using System.Text;
using System.Net;
using System.Net.Sockets;

namespace LightingClick
{
    class MyServer
    {
        /// <summary>
        /// 委托 接受到数据
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public delegate void AndSocketEventHandler(Object sender,AndSocketEventArgs e);

        public event AndSocketEventHandler AndSocketReceived;



        //端口
        private int _port = 4850;

        public int Port
        {
            get { return _port; }
            set { _port = value; }
        }

        //ip
        IPAddress _hostIP = IPAddress.Any;
        IPEndPoint _point;

        MySign mysign;
        UdpClient _socket;

        public MyServer(int port,MySign sign)
        {
            _port = port;
            mysign = sign;

        }

        public MyServer()
        {

        }



        public void StopListen()
        {
            if (_socket != null)
            {
                _socket.Close();
            }
        }

        public void StartListen()
        {
            _point = new IPEndPoint(_hostIP,_port);
            if (_socket != null)
            {
                try
                {
                    _socket.Close();
                }
                catch { }
            }
            IPAddress multicastIpAddress = IPAddress.Parse("224.0.0.1");
            _socket = new UdpClient(_port);
            _socket.JoinMulticastGroup(multicastIpAddress, 50);
            if (mysign == null)
            {
                mysign = new MySign();
                mysign.sign = true;
            }

            //_socket.Listen(50);
            //_acceptSocket = _socket.Accept();
            MyProcess();
        }

        public void MyProcess()
        {
            while (mysign.sign)
            {
                IPEndPoint sender = new IPEndPoint(IPAddress.Any, 0);
                byte[] recv = _socket.Receive(ref sender);

                string androidIP = Encoding.UTF8.GetString(recv, 0, recv.Length);
                AndSocketEventArgs e = new AndSocketEventArgs(androidIP);
                if (AndSocketReceived != null)
                {
                    AndSocketReceived(this,e);
                }

                MyClient.SendMessage("127.0.0.1", 4861, "HELLO");
            }
        }


    }
}