using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace teste.DAO
{
    public class produtosDAO
    {

        public void EditarProd(string id, string quantidade, string valor, string produto)
        {
            string query = "";

            query += "UPDATE Produtos SET Nome = '" + produto + "'," + "Valor = " + valor + ",Quantidade = " + quantidade + " WHERE Id = " + id + "";
            try
            {

                using (SqlConnection connection = new SqlConnection(conexaoBanco.ConexaoBanco()))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        {

                        }
                    }
                }


            }
            catch (Exception ex)
            {
                ex.ToString();
            }
        }

        public void ExcluirProduto(string id)
        {
            string query = "DELETE FROM Produtos WHERE Id = " + id + "";

            try
            {

                using (SqlConnection connection = new SqlConnection(conexaoBanco.ConexaoBanco()))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        {

                        }
                    }
                }


            }
            catch (Exception ex)
            {
                ex.ToString();
            }
        }

        public void incluirProduto(string preco, string produto, string quantidade, string data)
        {
            string query = "";
            query += "INSERT INTO Produtos (Nome,Valor,Quantidade,Data_Inclusao) VALUES ('" + produto + "'," + preco.Replace("R$", "").Trim() + "," + quantidade + ",'" + data + "')";

            try
            {
                using (SqlConnection connection = new SqlConnection(conexaoBanco.ConexaoBanco()))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        {

                        }
                    }
                }


            }
            catch (Exception ex)
            {
                ex.ToString();
            }
        }

        public List<string> buscarDados(string filtroQuery)
        {
            string query = "SELECT COUNT(*) AS TotalProd, SUM(Quantidade) as 'SomaQuantidade', SUM(valor) AS ValorProduto, SUM(Valor * Quantidade) AS SomaProduto FROM Produtos WHERE Id IS NOT NULL " + filtroQuery;
            List<string> list = new List<string>();
            DataTable dt = new DataTable();
            try
            {
                using (SqlConnection connection = new SqlConnection(conexaoBanco.ConexaoBanco()))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();

                        dt.Load(reader);

                        if (dt.Rows.Count > 0)
                        {
                            string totalProd = dt.Rows[0]["TotalProd"].ToString();
                            string somaQuantidade = dt.Rows[0]["SomaQuantidade"].ToString();
                            string valorProduto = dt.Rows[0]["ValorProduto"].ToString();
                            string somaProduto = dt.Rows[0]["SomaProduto"].ToString();

                            list.Add(totalProd);
                            list.Add(somaQuantidade);
                            list.Add(valorProduto);
                            list.Add(somaProduto);
                        }
                    }
                }
                return list;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

    }
}