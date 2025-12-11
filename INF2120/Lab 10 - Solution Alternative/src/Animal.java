
public class Animal {
      private String sorte;   //chien, chat, requin, etc.
      private String couleur; 
      private int age;
      //private String cri;
      
      public Animal(String sorte, String couleur, int age) {
         this.sorte = sorte;     
         this.couleur = couleur; 
         this.age = age;            
      }

      public String getSorte() {
         return sorte;
      }
      
      public String getCouleur() {
         return couleur;
      }

      public int getAge() {
         return age;
      }

      /*
      public String getCri() {
         return cri;
      }
      */

      public void setSorte(String sorte) {
         this.sorte = sorte;
      }

      public void setCouleur(String couleur) {
         this.couleur = couleur;
      }

      public void setAge(int age) {
         this.age = age;
      }

      /*
      public void setCri(String cri) {
         this.cri = cri;
      }
      */
      
      public String toString() {
         return sorte + " de couleur " + couleur + " (" + age + " ans)";
      }
      
   }
