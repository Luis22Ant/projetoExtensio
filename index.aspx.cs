using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace teste
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BtnEntrar_Click(object sender, EventArgs e)
        {

            if (TxtUsuario.Text == "")
            {
                LbMsg.Text = "Digite o nome de usuário!";
                modalUsuario.Attributes.Add("style", "display:flex;");
                BackgroundIncluir.Attributes.Add("style", "display:block;");
                return;
            }

            if (TxtSenha.Text == "")
            {
                LbMsg.Text = "Digite a senha!";
                modalUsuario.Attributes.Add("style", "display:flex;");
                BackgroundIncluir.Attributes.Add("style", "display:block;");
                return;
            }
            string query = "";
            query = "SELECT Login, Senha,Acesso FROM Login WHERE Login = @Login AND Senha = @Senha";
            try
            {
                using (SqlConnection connection = new SqlConnection(conexaoBanco.ConexaoBanco()))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@Login", TxtUsuario.Text);
                        command.Parameters.AddWithValue("@Senha", TxtSenha.Text);

                        using (SqlDataReader reader = command.ExecuteReader())
                        {

                            if (reader.Read())
                            {
                                Session["tipoAcesso"] = reader["Acesso"].ToString();

                            }
                            if (reader.HasRows)
                            {
                                Session["usuario"] = TxtUsuario.Text;
                                string redirectUrl = "produtos.aspx";
                                string script = "window.location = '" + redirectUrl + "';";
                                ClientScript.RegisterStartupScript(this.GetType(), "Redirect", script, true);

                            }
                            else
                            {
                                LbMsg.Text = "Usuário não cadastrado/ou inválido!";
                                modalUsuario.Attributes.Add("style", "display:flex;");
                                BackgroundIncluir.Attributes.Add("style", "display:block;");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                {
                    ex.ToString();
                }
            }
        }

        protected void BtnConfirmar_Click(object sender, EventArgs e)
        {
            modalUsuario.Attributes.Add("style", "display:none;");
            BackgroundIncluir.Attributes.Add("style", "display:none;");

        }
    }
}