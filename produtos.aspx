<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="produtos.aspx.cs" Inherits="teste.produtos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="Font/fontawesome.js"></script>
    <link rel="icon" href="Img/sopa.jpg" />
    <link rel="stylesheet" href="Css/bootStrap.css" />

    <style>
        .button {
            margin-bottom: 1vh;
            width: 10vh;
            text-align: center;
            background-color: #3b1f1b;
            padding: 4px;
            text-decoration: none;
            color: #b99968;
            border-radius: 9px;
        }

        #GdvProdutos tr:first-child {
            position: sticky;
            top: 0;
        }

        #GdvProdutos td {
            padding: 5px;
            border: 1px solid;
            color: black;
        }

        #GdvProdutos th {
            padding: 5px !important;
            border: 1px solid black !important;
            text-wrap: nowrap;
            color: #b99968;
        }

        .modalIncluir {
            text-align: center;
            background-color: white;
            color: black;
            width: 55vw;
            height: 53vh;
            position: absolute;
            bottom: 29%;
            /*            border-radius: 50px;*/
            left: 23%;
            z-index: 14;
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

        .infoRelacao {
            background-color: #e3eaeb;
            color: black;
            border: 1px solid;
            padding: 5px;
        }

        footer {
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 8vh;
            background-color: #3b1f1b;
            color: white;
            /*            display: flex;*/
            /*         align-items: center;*/
        }

        .buttonSair {
            text-decoration: none;
            color: #3b1f1b;
            background-color: #b99968;
            padding: 2px;
            position: absolute;
            text-align: center;
            width: 5vw;
            border-radius: 13px;
        }

        .buttonFiltro {
            background-color: #3b1f1b;
            color: #b99968;
            text-decoration: none;
            padding: 5px;
            border-radius: 15px;
            cursor: pointer;
            border: 1px solid black;
        }

        .modalFiltro {
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

        .buttonOk {
            background-color: green;
            padding: 5px;
            width: 5vw;
            border-radius: 14px;
            color: white;
            border: 1px solid black;
            cursor: pointer;
        }

        .divGdv {
            height: 41vh;
            margin-top: 0vh;
            width: 56vw;
            overflow: auto;
            margin-right: 2vh;
            margin-bottom: 1vh;
            padding-bottom: 1vh;
            scrollbar-width: thin;
            scrollbar-color: #888 #f1f1f1;
        }

            .divGdv::-webkit-scrollbar {
                width: 12px;
            }

            .divGdv::-webkit-scrollbar-thumb {
                background-color: #3b1f1b;
                border-radius: 6px;
            }

            .divGdv::-webkit-scrollbar-track {
                background-color: #f1f1f1;
            }

        .imgSopa {
            width: 8vw;
        }
    </style>
    <title>Estoque</title>
</head>
<body style="margin: 0;">
    <form id="form1" runat="server">
        <header>
            <div style="background-color: #3b1f1b; padding: 5px; margin-bottom: 3vh; color: white; margin-right: 0;" class="row">
                <div class="col-md-1">
                    <a href="https://www.instagram.com/sopadospobres/" style="cursor:pointer" target="_blank"><img src="Img/sopados.jpg" class="imgSopa" /></a>
                </div>
                <div class="col-md-3" style="display: flex; align-items: center;">
                    <h2 style="margin-left: 1rem; color: #b99968;">Ficha de Estoque</h2>
                </div>
            </div>
        </header>
        <div id="campoFiltros" class="row" style="margin: 0px 0px 2vh 0px;">
            <div class="col-md-1">
                <asp:DropDownList ID="DdlAno" runat="server" Style="width: 7vw; border: 1px solid;" CssClass="form-control">
                    <asp:ListItem Text="Ano" Value="0"></asp:ListItem>
                    <asp:ListItem Text="2023" Value="2023"></asp:ListItem>
                    <asp:ListItem Text="2022" Value="2022"></asp:ListItem>
                    <asp:ListItem Text="2021" Value="2021"></asp:ListItem>
                    <asp:ListItem Text="2020" Value="2020"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-md-1">
                <asp:DropDownList runat="server" ID="DdlMes" Style="width: 7vw; border: 1px solid;" OnSelectedIndexChanged="DdlMes_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control">
                    <asp:ListItem Text="Mês" Value="0"></asp:ListItem>
                    <asp:ListItem Text="Janeiro" Value="01"></asp:ListItem>
                    <asp:ListItem Text="Fevereiro" Value="02"></asp:ListItem>
                    <asp:ListItem Text="Março" Value="03"></asp:ListItem>
                    <asp:ListItem Text="Abril" Value="04"></asp:ListItem>
                    <asp:ListItem Text="Maio" Value="05"></asp:ListItem>
                    <asp:ListItem Text="Junho" Value="06"></asp:ListItem>
                    <asp:ListItem Text="Julho" Value="07"></asp:ListItem>
                    <asp:ListItem Text="Agosto" Value="08"></asp:ListItem>
                    <asp:ListItem Text="Setembro" Value="09"></asp:ListItem>
                    <asp:ListItem Text="Outubro" Value="10"></asp:ListItem>
                    <asp:ListItem Text="Novembro" Value="11"></asp:ListItem>
                    <asp:ListItem Text="Dezembro" Value="12"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-md-1">
                <asp:DropDownList runat="server" ID="DdlDia" Style="width: 7vw; border: 1px solid;" CssClass="form-control">
                    <asp:ListItem Text="Dia" Value=""></asp:ListItem>
                </asp:DropDownList>

            </div>
            <div class="col-md-3">
                <asp:DropDownList ID="DdlOrdenar" runat="server" Style="width: 12vw; border: 1px solid;" CssClass="form-control">
                    <asp:ListItem Text="Ordenar por: A-Z" Value="0"></asp:ListItem>
                    <asp:ListItem Text="Maior valor total" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Menor valor total" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Maior quantidade" Value="3"></asp:ListItem>
                    <asp:ListItem Text="Menor quantidade" Value="4"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-md-3">
            </div>
            <div class="col-md-3" style="text-align: right; display: flex; justify-content: center; align-items: center;">
                <asp:LinkButton runat="server" ID="LbtnLimparFiltro" Text="Limpar Filtros" CssClass="buttonFiltro form-control" OnClick="LbtnLimparFiltro_Click" Style="background-color: #b99968; color: #3b1f1b; text-align: center; margin-right: 3vh;"></asp:LinkButton>
                <asp:LinkButton runat="server" ID="LbtnFiltroPesquisar" Style="text-align: center;" Text="Pesquisar" OnClick="LbtnFiltroPesquisar_Click" CssClass="buttonFiltro form-control"></asp:LinkButton>
            </div>
        </div>
        <div style="margin-bottom: 1vh; margin-left: 1rem;">
            <asp:LinkButton runat="server" Text="Incluir" ID="BtnIncluir" OnClick="BtnIncluir_Click" CssClass="button form-control"></asp:LinkButton>
            <%--            <asp:LinkButton runat="server" Text="Pesquisar" ID="BtnPesquisar" OnClick="BtnPesquisar_Click" CssClass="button"></asp:LinkButton>--%>
            <%--            <asp:TextBox runat="server" placeholder="Mês" ID="TxtMes"></asp:TextBox>--%>
        </div>

        <div style="margin-left: 1rem;" class="divGdv">
            <asp:GridView ID="GdvProdutos" runat="server" OnRowDataBound="GdvProdutos_RowDataBound" Style="width: 55vw;">

                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <i class="fa-solid fa-eye" style="color: black;"></i>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton runat="server" ToolTip="Editar" ID="BtnEditar" OnClick="BtnEditar_Click" Style="color: black;"> <i class="fa-solid fa-pen"></i></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton runat="server" ToolTip="Excluir" ID="BtnExcluir" OnClick="BtnExcluir_Click" Style="color: black;"><i class="fa-solid fa-trash"></i></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>

                <RowStyle BackColor="#E3EAEB" />
                <HeaderStyle BackColor="#3b1f1b" ForeColor="White" />
            </asp:GridView>
        </div>
        <div>
            <table style="margin-left: 1rem; margin-top: 1rem; width: 55vw;">
                <tr>
                    <td style="border: 1px solid black !important; padding: 5px; background-color: #3b1f1b; color: #b99968;" colspan="4">RELAÇÃO DA PLANILHA</td>
                </tr>
                <tr>
                    <td id="prodCadastrados" class="infoRelacao" runat="server">Produtos cadastrados:</td>
                    <td id="valorTotalProdutos" class="infoRelacao" runat="server">Valor:</td>
                    <td id="quantProdutos" class="infoRelacao" runat="server">Quantidade estoque:</td>
                    <td id="somaValorTotal" class="infoRelacao" runat="server">Soma total:</td>
                </tr>
            </table>
        </div>
        <footer>
            <div class="row" style="margin-top: 2vh;">
                <div class="col-md-3">
                    <asp:Label runat="server" Style="margin-left: 2rem; color: #b99968;" ID="LbUsuario">USUÁRIO :&nbsp;</asp:Label>
                </div>
                <div class="col-md-5"></div>
                <div class="col-md-3" style="text-align: right;">
                    <asp:LinkButton runat="server" Text="Sair" CssClass="buttonSair" ID="LbtnSair" OnClick="LbtnSair_Click"></asp:LinkButton>
                </div>
            </div>
        </footer>


        <div class="modalIncluir" style="display: none;" id="ModalIncluir" runat="server">
            <div class="col-md-12" style="display: flex; background-color: #39201b; border: 1px solid;">
                <div style="margin-top: 2vh; font-size: 25px; text-align: left; margin-left: 1vh; margin-bottom: 5vh;" class="col-md-8">
                    <asp:Label runat="server" ID="LbCadastro" Style="color: #b99968;"></asp:Label>
                </div>
                <div class="col-md-4" style="text-align: right;">
                    <img src="Img/sopados.jpg" style="width: 15vh; margin-right: 1vh;" />
                </div>
            </div>

            <div style="text-align: left; background-color: #e3eaeb; border: 1px solid;" class="col-md-12">
                <div style="margin-bottom: 1vh;" class="col-md-4">
                    <asp:TextBox runat="server" CssClass="form-control" Style="border: 1px solid; margin-left: 1vh; top: 1vh; position: relative;"
                        placeholder="Nome do produto" ID="TxtProduto"></asp:TextBox>

                </div>
                <div style="margin-bottom: 1vh;" class="col-md-4">
                    <asp:TextBox runat="server" CssClass="form-control" placeholder="Preço do produto" Style="border: 1px solid; margin-left: 1vh; top: 1vh; position: relative;"
                        ID="TxtPreco"></asp:TextBox>

                </div>
                <div style="margin-bottom: 3vh;" class="col-md-4">
                    <asp:TextBox runat="server" CssClass="form-control" placeholder="Quantidade do produto" Style="border: 1px solid; margin-left: 1vh; top: 1vh; position: relative;"
                        ID="TxtQuantidade"></asp:TextBox>
                </div>
                <div style="text-align: right; margin-top: 11vh; margin-right: 7vh; display: flex; justify-content: flex-end;">
                    <asp:LinkButton runat="server" Text="Voltar" ID="BtnVoltar" OnClick="BtnVoltar_Click" CssClass="button form-control" Style="background-color: #b99968; color: #3b1f1b;"></asp:LinkButton>

                    <asp:LinkButton runat="server" Text="Confirmar" ID="BtnConfirmar" OnClick="BtnConfirmar_Click" CssClass="button form-control" Style="background-color: #3b1f1b; color: #b99968; width: 14vh; margin-left: 2vh;"></asp:LinkButton>
                </div>
            </div>
        </div>
        <div class="modalFiltro" id="modalFiltro" runat="server">
            <div>
                <asp:Label runat="server" ID="LbMsg" Style="font-weight: bold;" Text=""></asp:Label>
            </div>
            <div>
                <asp:Button ID="BtnSairModal" runat="server" Text="Ok!" CssClass="buttonOk" OnClick="BtnSairModal_Click"></asp:Button>
            </div>
        </div>
        <div id="BackgroundIncluir" class="backGroundModal" style="display: none;" runat="server">
        </div>


    </form>
</body>
</html>
