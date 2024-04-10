using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Diagnostics;
using System.Formats.Asn1;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace bioguardianes_api.Controllers

{
    public class ValuesController : Controller
    {
        private readonly string connectionString = "Server=localhost;Port=3306;Database=SistemaBiomonitores;Uid=root;";

        [HttpGet("signin")]
        public int? GetSignIn([FromQuery]string correo, [FromQuery] string contrasena, [FromQuery] bool isAdmin = false)
        {
            MySqlConnection connection = new(connectionString);
            connection.Open();
            MySqlCommand cmd = new();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = connection;
            cmd.CommandText = (isAdmin ? "admin_sign_in" : "biomonitor_sign_in");

            cmd.Parameters.AddWithValue("@correo", correo);
            cmd.Parameters.AddWithValue("@contrasena", contrasena);
            int? res = null;

            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    res = Convert.ToInt32(reader["biomonitor_id"]);
                }
            }
            connection.Dispose();
            return res;
        }

        [HttpGet("biomonitores")]
        public IEnumerable<Biomonitor> GetBiomonitores()
        {
            MySqlConnection connection = new(connectionString);
            connection.Open();
            MySqlCommand cmd = new();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = connection;
            cmd.CommandText = "get_biomonitores";


            List<Biomonitor> biomonitors = new();

            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    Biomonitor biomonitor = new()
                    {
                        BiomonitorId = Convert.ToInt32(reader["biomonitor_id"]),
                        AdministradorId = Convert.ToInt32(reader["administrador_id"]),
                        Nombre = reader["nombre"]?.ToString() ?? "NULL",
                        Apellidos = reader["apellidos"]?.ToString() ?? "NULL",
                        Correo = reader["correo"]?.ToString() ?? "NULL",
                        Telefono = reader["telefono"]?.ToString() ?? "NULL",
                        // FIXME
                        //FechaNacimiento = DateOnly.Parse(reader["fecha_nacimiento"]?.ToString() ?? "01-01-0001"),
                        Ciudad = reader["ciudad"]?.ToString() ?? "NULL",
                        Estado = Convert.ToBoolean(reader["estado"])
                    };
                    biomonitors.Add(biomonitor);
                }
            }
            connection.Dispose();

            return biomonitors;
        }

        [HttpGet("biomonitor/{biomonitor_id}")]
        public Biomonitor GetBiomonitor(int biomonitor_id)
        {
            MySqlConnection connection = new(connectionString);
            connection.Open();
            MySqlCommand cmd = new();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = connection;
            cmd.CommandText = "get_biomonitore_by_id";
            cmd.Parameters.AddWithValue("@biomonitor_id", biomonitor_id);

            Biomonitor biomonitor = new();

            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    biomonitor = new()
                    {
                        BiomonitorId = Convert.ToInt32(reader["biomonitor_id"]),
                        AdministradorId = Convert.ToInt32(reader["administrador_id"]),
                        Nombre = reader["nombre"]?.ToString() ?? "NULL",
                        Apellidos = reader["apellidos"]?.ToString() ?? "NULL",
                        Correo = reader["correo"]?.ToString() ?? "NULL",
                        Telefono = reader["telefono"]?.ToString() ?? "NULL",
                        // FIXME
                        //FechaNacimiento = DateOnly.Parse(reader["fecha_nacimiento"]?.ToString() ?? "01-01-0001"),
                        Ciudad = reader["ciudad"]?.ToString() ?? "NULL",
                        Estado = Convert.ToBoolean(reader["estado"])
                    };
                }
            }
            connection.Dispose();

            return biomonitor;
        }

        [HttpGet("biomonitor_progress/{biomonitor_id}")]
        public List<NivelBiomonitor> GetLevelProgress(int biomonitor_id)
        {
            MySqlConnection connection = new(connectionString);
            connection.Open();
            MySqlCommand cmd = new();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = connection;
            cmd.CommandText = "game_completion";
            cmd.Parameters.AddWithValue("@biomonitor_id", biomonitor_id);

            List<NivelBiomonitor> listaNivelBiomonitor = new();

            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    NivelBiomonitor nivelBiomonitor = new()
                    {
                        BiomonitorId = Convert.ToInt32(reader["biomonitor_id"]),
                        NivelId = Convert.ToInt32(reader["nivel_id"]),
                        Estrellas = Convert.ToInt32(reader["estrellas"]),
                        Insignia = Convert.ToBoolean(reader["insignia"]),
                        TiempoDedicado = Convert.ToInt32(reader["tiempo_dedicado"]),
                        PorcentajeDeTrivia = Convert.ToDouble(reader["porcentaje_de_trivia"])
                    };
                    listaNivelBiomonitor.Add(nivelBiomonitor);
                }
            }
            connection.Dispose();

            return listaNivelBiomonitor;
        }

        //[HttpPut("updateStars/{biomonitor_id}/{nivel_id}")]
        //public void PutEstrellas(int biomonitor_id, int nivel_id, [FromQuery] int estrellas = 0)
        //{
        //    MySqlConnection connection = new MySqlConnection(connectionString);
        //    connection.Open();
        //    MySqlCommand cmd = new MySqlCommand();
        //    cmd.CommandType = CommandType.StoredProcedure;
        //    cmd.Connection = connection;
        //    cmd.CommandText = "force_update_biomonitor_level_stars";
        //    cmd.Parameters.AddWithValue("@biomonitor_id", biomonitor_id);
        //    cmd.Parameters.AddWithValue("@nivel_id", nivel_id);
        //    cmd.Parameters.AddWithValue("@estrellas", estrellas);

        //    cmd.ExecuteNonQuery();
        //    connection.Dispose();
        //}

        //[HttpPut("updatePercentage/{biomonitor_id}/{nivel_id}")]
        //public void PutPorcentaje(int biomonitor_id, int nivel_id, [FromQuery] int porcentaje = 0)
        //{
        //    MySqlConnection connection = new MySqlConnection(connectionString);
        //    connection.Open();
        //    MySqlCommand cmd = new MySqlCommand();
        //    cmd.CommandType = CommandType.StoredProcedure;
        //    cmd.Connection = connection;
        //    cmd.CommandText = "update_biomonitor_level_percentage";
        //    cmd.Parameters.AddWithValue("@biomonitor_id", biomonitor_id);
        //    cmd.Parameters.AddWithValue("@nivel_id", nivel_id);
        //    cmd.Parameters.AddWithValue("@estrellas", porcentaje);

        //    cmd.ExecuteNonQuery();
        //    connection.Dispose();
        //}

        //[HttpPut("updateBadge/{biomonitor_id}/{nivel_id}")]
        //public void PutInsignia(int biomonitor_id, int nivel_id, [FromQuery] bool insignia = false)
        //{
        //    MySqlConnection connection = new MySqlConnection(connectionString);
        //    connection.Open();
        //    MySqlCommand cmd = new MySqlCommand();
        //    cmd.CommandType = CommandType.StoredProcedure;
        //    cmd.Connection = connection;
        //    cmd.CommandText = "update_biomonitor_level_badge";
        //    cmd.Parameters.AddWithValue("@biomonitor_id", biomonitor_id);
        //    cmd.Parameters.AddWithValue("@nivel_id", nivel_id);
        //    cmd.Parameters.AddWithValue("@insignia", insignia);

        //    cmd.ExecuteNonQuery();
        //    connection.Dispose();
        //}

        //[HttpPut("forceTime/{biomonitor_id}/{nivel_id}")]
        //public void PutTiempo(int biomonitor_id, int nivel_id, [FromQuery] int tiempo_dedicado = 0)
        //{
        //    MySqlConnection connection = new MySqlConnection(connectionString);
        //    connection.Open();
        //    MySqlCommand cmd = new MySqlCommand();
        //    cmd.CommandType = CommandType.StoredProcedure;
        //    cmd.Connection = connection;
        //    cmd.CommandText = "force_update_biomonitor_level_time";
        //    cmd.Parameters.AddWithValue("@biomonitor_id", biomonitor_id);
        //    cmd.Parameters.AddWithValue("@nivel_id", nivel_id);
        //    cmd.Parameters.AddWithValue("@tiempo_dedicado", tiempo_dedicado);

        //    cmd.ExecuteNonQuery();
        //    connection.Dispose();
        //}

        [HttpPut("updateLevel/{biomonitor_id}/{nivel_id}")]
        public void PutLevel(int biomonitor_id, int nivel_id, [FromQuery] int estrellas = 0, [FromQuery] double porcentaje = 0,[FromQuery] int tiempo_dedicado = 0, [FromQuery] bool insignia = false)
        {
            MySqlConnection connection = new MySqlConnection(connectionString);
            connection.Open();
            MySqlCommand cmd = new MySqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = connection;
            cmd.CommandText = "update_biomonitor_level";
            cmd.Parameters.AddWithValue("@biomonitor_id", biomonitor_id);
            cmd.Parameters.AddWithValue("@nivel_id", nivel_id);
            cmd.Parameters.AddWithValue("@estrellas", estrellas);
            cmd.Parameters.AddWithValue("@porcentaje", porcentaje);
            cmd.Parameters.AddWithValue("@tiempo_dedicado", tiempo_dedicado);
            cmd.Parameters.AddWithValue("@insignia", insignia);

            cmd.ExecuteNonQuery();
            connection.Dispose();
        }


    }
}

