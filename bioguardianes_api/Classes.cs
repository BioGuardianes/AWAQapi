using System;
namespace bioguardianes_api
{
	public class Administrador
	{
		public int AdministradorId { get; set; }
		public string Nombre { get; set; }
        public string Apellidos { get; set; }
        public string Correo { get; set; }

		public Administrador()
		{
			this.AdministradorId = 0;
			this.Nombre = "John";
            this.Apellidos = "Doe";
			this.Correo = "place@holder.com";
        }

    }

    public class Biomonitor
    {
        public int BiomonitorId { get; set; }
        public int AdministradorId { get; set; }
        public string Nombre { get; set; }
        public string Apellidos { get; set; }
        public string Correo { get; set; }
        public string Telefono { get; set; }
        public DateOnly FechaNacimiento { get; set; }
        public string Ciudad { get; set; }
        public bool Estado { get; set; }

        public Biomonitor()
        {
            this.BiomonitorId = 0;
            this.AdministradorId = 0;
            this.Nombre = "John";
            this.Apellidos = "Doe";
            this.Correo = "place@holder.com";
            this.Telefono = "0123456789";
            this.FechaNacimiento = DateOnly.MinValue;
            this.Ciudad = "MTY";
            this.Estado = false;
        }

    }

    public class NivelBiomonitor
    {
        public int BiomonitorId { get; set; }
        public int NivelId { get; set; }
        public int Estrellas { get; set; }
        public bool Insignia { get; set; }
        public int TiempoDedicado { get; set; }
        public double PorcentajeDeTrivia { get; set; }
        public int TutorialCompletado { get; set; }

        public NivelBiomonitor()
        {
            this.BiomonitorId = 0;
            this.NivelId = 0;
            this.Estrellas = 0;
            this.Insignia = false;
            this.TiempoDedicado = 0;
            this.PorcentajeDeTrivia = 0.0;
            this.TutorialCompletado = 0;
        }

    }
}

