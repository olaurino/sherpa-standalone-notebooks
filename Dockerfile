#****************************************************************************
# A Sherpa Dockerfile. From an example by Andrew Odewahn (@odewahn)
#
#  - https://github.com/DougBurke/sherpa-standalone-notebooks
#  - https://github.com/sherpa/sherpa
#  - https://hub.docker.com/r/continuumio/miniconda/
#
#****************************************************************************
FROM continuumio/miniconda

MAINTAINER Omar Laurino <olaurino@cfa.harvard.edu>

#****************************************************************************
# Install required conda libraries
#****************************************************************************

RUN source activate python3

RUN conda install -c sherpa -y \
  ipython-notebook matplotlib astropy scipy sherpa=4.8 nomkl && \
  conda remove -y --force qt pyqt qtconsole && \ 
  conda clean -tipsy && \
  rm -rf /opt/conda/pkgs/*

# Expose the notebook port
EXPOSE 8888

# Add notebooks to image
ADD . /data

# Set working dir
WORKDIR /data

# Mount conda environments folder as volume for persistence
VOLUME /opt/conda/envs

#****************************************************************************
# Fire it up
#****************************************************************************
CMD ipython notebook --no-browser --port 8888 --ip=*

