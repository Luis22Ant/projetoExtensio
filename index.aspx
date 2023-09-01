<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="teste.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="icon" href="Img/sopa.jpg" />
    <link rel="stylesheet" href="Css/bootStrap.css" />
    <link rel="stylesheet" href="Css/login.css" />
    <link rel="stylesheet" href="Css/login.css" />
    <style>
        .modalIncluir {
            text-align: center;
            justify-content: space-around;
            background-color: white;
            display: none;
            font-size: 22px;
            color: black;
            width: 23vw;
            height: 26vh;
            position: absolute;
            bottom: 40%;
            border-radius: 50px;
            left: 39%;
            border: 2px solid black;
            z-index: 14;
            flex-direction: column;
            align-items: center;
        }

        .backGroundModal {
            width: 100%;
            background-color: black;
            height: 100%;
            opacity: 0.5;
            z-index: 12;
            bottom: 0vh;
            position: absolute;
            left: 0;
        }

        .buttonOk {
            background-color: green;
            padding: 5px;
            width: 5vw;
            border-radius: 14px;
            color: white;
            border: 1px solid black;
            cursor: pointer;
        }
    </style>
    <title>Login</title>
</head>
<body style="text-align: center; background-color: #3b1f1b;">
    <form id="form1" runat="server">
        <div class="row" style="margin: 0; flex-direction: column; align-items: center;">
            <div>
                <img src="Img/sopados.jpg" style="width: 23vw;" />
            </div>
            <div style="margin-bottom: 1vh;" class="col-md-2">
                <asp:TextBox runat="server" type="text" ID="TxtUsuario" CssClass="form-control" placeholder="Usuário" />
            </div>
            <div style="margin-bottom: 1vh;" class="col-md-2">
                <asp:TextBox runat="server" type="password" ID="TxtSenha" CssClass="form-control" placeholder="Senha" />
            </div>
            <div style="text-align: center;" class="col-md-2">
                <asp:LinkButton CssClass="buttonLogin form-control" Style="background-color: #b99968; color: #3b1f1b !important;" runat="server" ID="BtnEntrar" OnClick="BtnEntrar_Click" Text="Entrar"></asp:LinkButton>
            </div>

        </div>


        <div class="modalIncluir" id="modalUsuario" runat="server">
            <div>
                <asp:Label runat="server" ID="LbMsg" Style="font-weight: bold;" Text="Usuário não cadastrado/ou inválido!"></asp:Label>
            </div>
            <div>
                <asp:Button ID="BtnConfirmar" runat="server" Text="Ok!" CssClass="buttonOk" OnClick="BtnConfirmar_Click"></asp:Button>
            </div>
        </div>
        <div id="BackgroundIncluir" class="backGroundModal" style="display: none;" runat="server">
        </div>
    </form>
</body>
</html>
