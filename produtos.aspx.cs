using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using teste.DAO;

namespace teste
{
    public partial class produtos : System.Web.UI.Page
    {
        produtosDAO produtosDAO = new produtosDAO();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                carregarProd();
                LbUsuario.Text += Session["usuario"];

                if (Session["tipoAcesso"].ToString() == "U")
                {
                    BtnIncluir.Attributes.Add("style", "display:none;");
                }
            }
        }

        public DataTable carregarProd()
        {
            DataTable dt = new DataTable();
            string filtroQuery = "";
            string data = "";
            string ordernar = "ORDER BY Item ASC";
            List<string> listaDados = new List<string>();
            try
            {


                if (DdlMes.SelectedValue != "0")
                {
                    if (DdlAno.SelectedValue == "0")
                    {
                        LbMsg.Text = "Selecione um ano!";
                        modalFiltro.Attributes.Add("style", "display:flex;");
                        BackgroundIncluir.Attributes.Add("style", "display:flex;");
                        return dt;
                    }
                    if (DdlDia.SelectedValue != "")
                    {
                        data = DdlAno.Text + DdlMes.SelectedValue + DdlDia.SelectedValue;

                    }
                    else
                    {
                        data = DdlAno.Text + DdlMes.SelectedValue;

                    }
                    filtroQuery += "AND Data_Inclusao LIKE '%" + data + "%'";

                }
                if (DdlAno.SelectedValue != "0" && DdlMes.SelectedValue == "0")

                {
                    filtroQuery += "AND Data_Inclusao BETWEEN " + DdlAno.SelectedValue + "0101 AND " + DdlAno.SelectedValue + "1231";
                }

                if (DdlOrdenar.SelectedValue != "0")
                {
                    ordernar = ordenarValores();
                }



                string query = "SELECT Id AS 'ID',Nome AS 'ITEM',Valor AS 'VALOR UNITÁRIO',Quantidade AS 'QUANTIDADE', CAST(Valor * Quantidade AS DECIMAL(10, 2)) AS 'VALOR TOTAL' FROM Produtos WHERE Id IS NOT NULL " + filtroQuery + " " + ordernar;

                using (SqlConnection connection = new SqlConnection(conexaoBanco.ConexaoBanco()))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        dt.Load(reader);
                    }
                }
                listaDados = produtosDAO.buscarDados(filtroQuery);
                valorTotalProdutos.InnerText = "Valor:" + listaDados[2];
                prodCadastrados.InnerText = "Produtos cadastrados:" + listaDados[0];
                somaValorTotal.InnerText = "Soma total:" + listaDados[3];
                quantProdutos.InnerText = "Quantidade total:" + listaDados[1];

                GdvProdutos.DataSource = dt;
                GdvProdutos.AutoGenerateColumns = true;
                GdvProdutos.DataBind();
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            return dt;
        }

        protected void BtnIncluir_Click(object sender, EventArgs e)
        {
            LbCadastro.Text = "TELA DE CADASTRO DE PRODUTO!";
            Session["acao"] = "Incluir";
            ModalIncluir.Attributes.Add("style", "display:block");
            BackgroundIncluir.Attributes.Add("style", "display:block");
        }

        protected void BtnEditar_Click(object sender, EventArgs e)
        {
            GridViewRow row = (GridViewRow)(sender as Control).Parent.Parent;
            int index = row.DataItemIndex;
            string id = GdvProdutos.Rows[index].Cells[3].Text;
            string produto = HttpUtility.HtmlDecode(GdvProdutos.Rows[index].Cells[4].Text);
            string valor = GdvProdutos.Rows[index].Cells[5].Text;
            string quantidade = GdvProdutos.Rows[index].Cells[6].Text;
            Session["id"] = id;
            Session["acao"] = "Editar";
            TxtProduto.Text = produto;
            TxtPreco.Text = valor;
            TxtQuantidade.Text = quantidade;
            LbCadastro.Text = "TELA DE EDIÇÃO DE PRODUTO!";
            ModalIncluir.Attributes.Add("style", "display:block");
            BackgroundIncluir.Attributes.Add("style", "display:block");

        }

        protected void BtnExcluir_Click(object sender, EventArgs e)
        {
            GridViewRow row = (GridViewRow)(sender as Control).Parent.Parent;
            int index = row.DataItemIndex;
            string id = GdvProdutos.Rows[index].Cells[3].Text;
            Session["id"] = id;
            produtosDAO.ExcluirProduto(id);
            carregarProd();
            Response.Redirect("produtos.aspx");

        }

        protected void GdvProdutos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.Header)
            {
                e.Row.Cells[5].Text = "R$ " + e.Row.Cells[5].Text;
                e.Row.Cells[7].Text = "R$ " + e.Row.Cells[7].Text;
            }
        }

        protected void BtnPesquisar_Click(object sender, EventArgs e)
        {
            carregarProd();
        }

        protected void BtnConfirmar_Click(object sender, EventArgs e)
        {
            string data = DateTime.Now.ToString("yyyyMMdd");
            string precoAjustado = "";
            string precoVirgula = "";

            if (TxtPreco.Text.Contains(","))
            {
                precoVirgula = TxtPreco.Text.Replace(',', '.');
                precoAjustado = precoVirgula.Replace("R$", "").Trim();
            }
            else
            {
                precoAjustado = TxtPreco.Text.Replace("R$", "").Trim();
            }

            if (Session["acao"].ToString() == "Editar")
            {
                produtosDAO.EditarProd(Session["id"].ToString(), TxtQuantidade.Text, precoAjustado, TxtProduto.Text);
                carregarProd();
                Response.Redirect("produtos.aspx");
                return;
            }

            produtosDAO.incluirProduto(precoAjustado, TxtProduto.Text, TxtQuantidade.Text, data);
            ModalIncluir.Attributes.Add("style", "display:none");
            BackgroundIncluir.Attributes.Add("style", "display:none");
            carregarProd();
            Response.Redirect("produtos.aspx");

        }

        protected void BtnVoltar_Click(object sender, EventArgs e)
        {
            ModalIncluir.Attributes.Add("style", "display:none");
            BackgroundIncluir.Attributes.Add("style", "display:none");
        }



        protected void LbtnSair_Click(object sender, EventArgs e)
        {
            Response.Redirect("index.aspx");
        }

        protected void LbtnFiltroPesquisar_Click(object sender, EventArgs e)
        {
            carregarProd();
        }

        protected void LbtnLimparFiltro_Click(object sender, EventArgs e)
        {
            DdlOrdenar.SelectedValue = "0";
            DdlAno.SelectedValue = "0";
            DdlMes.SelectedValue = "0";
            DdlDia.Items.Clear();
            DdlDia.Items.Add(new ListItem("Dia", ""));
        }

        public string ordenarValores()
        {
            string ordernar = "";
            if (DdlOrdenar.SelectedValue == "1")
            {
                ordernar = " ORDER BY 'VALOR TOTAL' DESC";
            }
            else if (DdlOrdenar.SelectedValue == "2")
            {
                ordernar = " ORDER BY 'VALOR TOTAL' ASC";

            }
            else if (DdlOrdenar.SelectedValue == "3")
            {
                ordernar = " ORDER BY Quantidade DESC";

            }
            else if (DdlOrdenar.SelectedValue == "4")
            {
                ordernar = " ORDER BY Quantidade ASC";
            }
            return ordernar;
        }

        protected void BtnSairModal_Click(object sender, EventArgs e)
        {
            modalFiltro.Attributes.Add("style", "display:none;");
            BackgroundIncluir.Attributes.Add("style", "display:none;");
        }

        protected void DdlMes_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DdlMes.SelectedValue != "0")
            {
                DdlDia.Items.Clear();
                int diasMes = DateTime.DaysInMonth(int.Parse(DdlMes.SelectedValue), int.Parse(DdlMes.SelectedValue));
                List<int> listDias = new List<int>();
                listDias = DiasDoMes(diasMes);
                DdlDia.Items.Add(new ListItem("Dia", ""));

                try
                {
                    foreach (int dias in listDias)
                    {
                        if (dias < 10)
                        {
                            DdlDia.Items.Add(new ListItem(dias.ToString(), "0" + dias.ToString()));

                        }
                        else
                        {
                            DdlDia.Items.Add(new ListItem(dias.ToString(), dias.ToString()));

                        }
                    }

                }
                catch (Exception ex)
                {

                    ex.ToString();
                }
            }
            else
            {
                DdlDia.Items.Clear();
                DdlDia.Items.Add(new ListItem("Dia", ""));
            }

        }

        public List<int> DiasDoMes(int dias)
        {
            List<int> list = new List<int>();

            try
            {
                for (int i = 1; i <= dias; i++)
                {

                    list.Add(i);
                }

            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            return list;
        }
    }
}
;