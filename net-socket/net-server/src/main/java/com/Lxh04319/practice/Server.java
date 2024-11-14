package com.Lxh04319.practice;

import java.io.*;
import java.net.*;

public class Server {
    public static void main(String[] args) {
        ServerSocket serverSocket = null;
        Socket clientSocket = null;
        BufferedReader in = null;
        PrintWriter out = null;
        try {
            // 创建服务器端的
            serverSocket = new ServerSocket(12345);
            System.out.println("服务器已启动，等待客户端连接...");
            // 等待客户端连接
            clientSocket = serverSocket.accept();
            System.out.println("客户端已连接");
            // 获取输入输出流
            in = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
            out = new PrintWriter(clientSocket.getOutputStream(), true);
            // 读取客户端发送的消息并回复
            String clientMessage;
            while ((clientMessage = in.readLine()) != null) {
                System.out.println("客户端: " + clientMessage);
                out.println("服务器: " + clientMessage);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (in != null) in.close();
                if (out != null) out.close();
                if (clientSocket != null) clientSocket.close();
                if (serverSocket != null) serverSocket.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}